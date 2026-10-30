-- Show the track's BPM in the top right while the audio-only visualizer is active.
-- Uses the file's BPM tag when present, otherwise estimates it with ffmpeg.

local RATE = 8000        -- analysis sample rate
local HOP = 80           -- samples per onset frame (100 frames/s)
local SECONDS = 90       -- how much of the track to analyze
local MIN_BPM, MAX_BPM = 60, 200

local overlay = mp.create_osd_overlay("ass-events")
overlay.res_x, overlay.res_y = 1280, 720

local cache = {}
local pending
local current

local function render()
    local bpm = current and cache[current]
    if not bpm or mp.get_property("lavfi-complex", "") == "" then
        overlay:remove()
        return
    end
    mp.msg.verbose(bpm .. " BPM")
    overlay.data = string.format(
        "{\\an9\\pos(1260,20)\\fnFiraCode Nerd Font\\fs36\\bord0\\shad0\\1c&HCBC0FF&}%s BPM", bpm)
    overlay:update()
end

local function tag_bpm()
    for k, v in pairs(mp.get_property_native("metadata") or {}) do
        local key = k:lower()
        if key == "bpm" or key == "tbpm" then
            local n = tonumber(v)
            if n and n > 0 then return string.format("%d", math.floor(n + 0.5)) end
        end
    end
end

local function estimate(pcm)
    local frame_bytes = HOP * 2
    local nframes = math.floor(#pcm / frame_bytes)
    if nframes < 400 then return nil end

    -- Log energy per frame, then positive differences as an onset envelope.
    local onset, prev, sum = {}, nil, 0
    for f = 0, nframes - 1 do
        local bytes = { pcm:byte(f * frame_bytes + 1, (f + 1) * frame_bytes) }
        local e = 0
        for i = 1, #bytes, 2 do
            local s = bytes[i] + bytes[i + 1] * 256
            if s >= 32768 then s = s - 65536 end
            e = e + s * s
        end
        e = math.log(1 + e / HOP)
        local d = prev and math.max(0, e - prev) or 0
        onset[f + 1] = d
        sum = sum + d
        prev = e
    end
    local mean = sum / nframes
    for i = 1, nframes do onset[i] = onset[i] - mean end

    -- Autocorrelate over the tempo range, biased toward ~120 BPM to avoid octave errors.
    local fps = RATE / HOP
    local min_lag = math.floor(fps * 60 / MAX_BPM)
    local max_lag = math.ceil(fps * 60 / MIN_BPM)
    local scores = {}
    for lag = min_lag - 1, max_lag + 1 do
        local acc = 0
        for i = 1, nframes - lag do acc = acc + onset[i] * onset[i + lag] end
        local octaves = math.log((fps * 60 / lag) / 120) / math.log(2)
        scores[lag] = acc * math.exp(-0.5 * octaves * octaves)
    end
    local best = min_lag
    for lag = min_lag, max_lag do
        if scores[lag] > scores[best] then best = lag end
    end

    -- Parabolic interpolation for sub-frame lag precision.
    local a, b, c = scores[best - 1], scores[best], scores[best + 1]
    local denom = a - 2 * b + c
    local lag = best
    if denom ~= 0 then lag = best + 0.5 * (a - c) / denom end
    return string.format("%d", math.floor(fps * 60 / lag + 0.5))
end

local function analyze()
    if pending then
        mp.abort_async_command(pending)
        pending = nil
    end
    current = mp.get_property("path")
    if not current then return end

    if not cache[current] then
        cache[current] = tag_bpm()
    end
    if cache[current] or mp.get_property("lavfi-complex", "") == "" then
        render()
        return
    end

    local path = current
    pending = mp.command_native_async({
        name = "subprocess",
        playback_only = false,
        capture_stdout = true,
        capture_size = RATE * 2 * SECONDS + 4096,
        args = { "ffmpeg", "-nostdin", "-v", "error", "-t", tostring(SECONDS), "-i", path,
                 "-map", "0:a:0", "-ac", "1", "-ar", tostring(RATE), "-f", "s16le", "-" },
    }, function(success, result)
        pending = nil
        if not success or result.status ~= 0 then return end
        cache[path] = estimate(result.stdout)
        if path == current then render() end
    end)
end

mp.register_event("file-loaded", analyze)
mp.register_event("end-file", function() overlay:remove() end)
mp.observe_property("lavfi-complex", "string", function()
    if current and not cache[current] and not pending then analyze() else render() end
end)
