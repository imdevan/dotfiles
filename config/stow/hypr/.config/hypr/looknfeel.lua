-- Change the default Omarchy look'n'feel.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/

-- Current theme's active border color with a custom alpha (hex "AA").
-- Falls back to nil (theme default) if the color isn't a plain #rrggbb.
local function theme_active_border(alpha)
  local state = os.getenv("XDG_STATE_HOME") or (os.getenv("HOME") .. "/.local/state")
  local file = io.open(state .. "/omarchy/current/theme/hyprland.lua")
  if not file then
    return nil
  end
  local hex = file:read("a"):match('active_border_color%s*=%s*"#(%x%x%x%x%x%x)"')
  file:close()
  return hex and ("rgba(" .. hex .. alpha .. ")") or nil
end

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    -- gaps_in = 0,
    -- gaps_out = 0,
    -- border_size = 0,
    border_size = 1,
    -- border_size = 2,
    -- gaps_in = 8, gaps_out = 64, border_size = 2,

    col = {
      -- active_border = "rgba(52CFFFFF)", -- baby blue
      -- active_border = "rgba(94C7C8FF)", -- lighter blue
      -- active_border = "rgba(FD79F9FF)", -- pink
      -- active_border = "rgba(FEC4FF80)", -- light pink
      -- active_border = "rgba(E2C264FF)", -- yellow
      -- active_border = "rgba(4aeb85FF)", -- green
      active_border = theme_active_border("90"), -- theme color at 60% opacity
      inactive_border = "rgba(FFFFFF19)",        -- clear
      -- inactive_border = "rgba(000000aa)",
      -- inactive_border = "rgba(000000ff)", -- black
    },

    -- Use master layout instead of dwindle
    -- layout = "master",
  },

  -- xwayland = {
  --   force_zero_scaling = true,
  -- },

  -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
  decoration = {
    -- Use round window corners
    -- rounding = 0, 4, 12, 16
    rounding = 8,
    rounding_power = 4.0,

    blur = {
      -- Omarchy disables blur by default; the old config relied on it being on
      enabled = true,
      passes = 3,
      size = 6,
      -- Changes the color of the blurred area
      vibrancy = 0.5,
      -- vibrancy = 1,
      -- vibrancy_darkness = 0.5,
      -- brightness = 0.7, 1, 1.5, 2
      brightness = 1.5,
      -- brightness = 1.25,
      -- brightness = 1,
      -- Optional: Use xray to make windows look behind other windows
      -- xray = true,
    },
  },

  -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
  -- layout = {
  --   -- Avoid overly wide single-window layouts on wide screens
  --   single_window_aspect_ratio = { 1.6, 1 },
  -- },
})

-- Old config: layerrule = blur off, match:namespace waybar
-- The Omarchy 4 bar is the "omarchy-bar" layer, not waybar.
hl.layer_rule({ match = { namespace = "omarchy-bar" }, blur = false })
