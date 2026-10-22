-- Personal keybindings, loaded after Omarchy's defaults.
-- See current bindings and descriptions:
--   omarchy menu keybindings --print
-- Dispatchers: https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local scripts = "~/.config/hypr/scripts/"

-- Unbind first so the default doesn't fire alongside the new binding
local function rebind(keys, description, dispatcher, options)
  hl.unbind(keys)
  o.bind(keys, description, dispatcher, options)
end

-- Unbind defaults
-- ================================================================================
hl.unbind("CTRL + ALT + J")
hl.unbind("CTRL + ALT + H")
hl.unbind("CTRL + SHIFT + Q")
hl.unbind("SUPER + G") -- was: toggle window grouping

-- Menus / system
-- ================================================================================
rebind("SUPER + CTRL + SPACE", "Next background", "omarchy-theme-bg-next")
rebind("SUPER + CTRL + O", "Hardware menu", "omarchy-menu toggle hardware")
rebind("SUPER + SHIFT + K", "Show key bindings", "omarchy-menu-keybindings")
rebind("SUPER + SHIFT + R", "Reload Hyprland", "hyprctl reload")
rebind("SUPER + SHIFT + Q", "Close all windows", "omarchy-hyprland-window-close-all")

-- Default browser
rebind("SUPER + SHIFT + CTRL + 0", "Default browser: qutebrowser",
  "xdg-settings set default-web-browser qutebrowser.desktop")
rebind("SUPER + SHIFT + CTRL + 9", "Default browser: chromium", "xdg-settings set default-web-browser chromium.desktop")

-- Apps
-- ================================================================================
rebind("F1", "Terminal (workspace 1)", [[
  hyprctl dispatch 'hl.dsp.focus({ workspace = "1" })' &&
  omarchy-launch-or-focus "^kitty$" "uwsm-app -- xdg-terminal-exec --dir=\"$(omarchy-cmd-terminal-cwd)\"" ;
  hyprctl dispatch 'hl.dsp.window.move({ workspace = "1", window = "class:^(kitty)$" })'
]])
rebind("F2", "Qutebrowser", "omarchy-launch-or-focus qutebrowser")
rebind("F3", "Chromium", "omarchy-launch-or-focus chromium")
rebind("F4", "Obsidian", "omarchy-launch-or-focus obsidian")
rebind("F8", "Aether", "omarchy-launch-or-focus aether")
rebind("F9", "File manager", { launch = "nautilus --new-window", focus = "org.gnome.Nautilus" })
rebind("F10", "Chromium", "omarchy-launch-or-focus chromium")
-- rebind("F12", "Kiro run", scripts .. "kiro-run.sh")

-- Work sessions
rebind("SUPER + SHIFT + G", "Get to work", scripts .. "get-to-work.sh") -- was: Signal
rebind("SUPER + SHIFT + E", "End work", scripts .. "end-work.sh")       -- was: Email

-- Focus / swap (vim keys)
-- ================================================================================
rebind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
rebind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))       -- was: toggle workspace layout
rebind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))          -- was: keybindings menu
rebind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))        -- was: toggle split

rebind("SUPER + CTRL + H", "Swap window left", hl.dsp.window.swap({ direction = "l" })) -- was: hardware menu
rebind("SUPER + CTRL + L", "Swap window right", hl.dsp.window.swap({ direction = "r" }))
rebind("SUPER + CTRL + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))   -- was: herdr keybindings
rebind("SUPER + CTRL + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

-- Resize
-- ================================================================================
rebind("SUPER + ALT + H", "Shrink window width", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
rebind("SUPER + ALT + L", "Grow window width", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
rebind("SUPER + ALT + K", "Shrink window height", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
rebind("SUPER + ALT + J", "Grow window height", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))

rebind("SUPER + CTRL + SHIFT + N", "Shrink window width a lot",
  hl.dsp.window.resize({ x = -240, y = 0, relative = true }))
rebind("SUPER + CTRL + SHIFT + L", "Grow window width a lot", hl.dsp.window.resize({ x = 240, y = 0, relative = true }))
rebind("SUPER + CTRL + SHIFT + K", "Shrink window height a lot",
  hl.dsp.window.resize({ x = 0, y = -160, relative = true }))
rebind("SUPER + CTRL + SHIFT + J", "Grow window height a lot", hl.dsp.window.resize({ x = 0, y = 160, relative = true }))

-- Resize to 60% of the monitor and center (floating windows)
rebind("SUPER + CTRL + Y", "Resize to 60% and center", function()
  local monitor = hl.get_active_monitor()
  if not monitor then
    return
  end
  hl.dispatch(hl.dsp.window.resize({
    x = math.floor(monitor.width / monitor.scale * 0.6),
    y = math.floor(monitor.height / monitor.scale * 0.6),
  }))
  hl.dispatch(hl.dsp.window.center())
end)

-- Splits (dwindle)
-- ================================================================================
rebind("SUPER + SHIFT + J", "Toggle window split", hl.dsp.layout("togglesplit"))
rebind("SUPER + CTRL + ALT + H", "Toggle window split", hl.dsp.layout("togglesplit"))
rebind("SUPER + CTRL + ALT + V", "Toggle window split", hl.dsp.layout("togglesplit"))

rebind("SUPER + CTRL + 0", "Split ratio 1", hl.dsp.layout("splitratio 1 exact"))
rebind("SUPER + CTRL + ALT + 9", "Split ratio 1.56", hl.dsp.layout("splitratio 1.56 exact"))
rebind("SUPER + CTRL + 9", "Split ratio 1.33", hl.dsp.layout("splitratio 1.33 exact"))
rebind("SUPER + CTRL + 8", "Split ratio 1.25", hl.dsp.layout("splitratio 1.25 exact"))
rebind("SUPER + CTRL + 7", "Split ratio 0.75", hl.dsp.layout("splitratio 0.75 exact"))
rebind("SUPER + CTRL + 6", "Split ratio 0.66", hl.dsp.layout("splitratio 0.66 exact"))

-- Layout
-- ================================================================================
rebind("SUPER + SHIFT + CTRL + S", "Toggle workspace layout (dwindle/scrolling)",
  "omarchy-hyprland-workspace-layout-toggle")

-- Workspaces / monitors
-- ================================================================================
rebind("SUPER + SHIFT + L", "Next workspace (wrap at 5)", scripts .. "workspace-switch.sh next")
rebind("SUPER + SHIFT + H", "Previous workspace (wrap at 5)", scripts .. "workspace-switch.sh prev")
rebind("SUPER + SHIFT + RIGHT", "Next workspace (wrap at 5)", scripts .. "workspace-switch.sh next")    -- was: swap window right
rebind("SUPER + SHIFT + LEFT", "Previous workspace (wrap at 5)", scripts .. "workspace-switch.sh prev") -- was: swap window left

rebind("SUPER + SHIFT + CTRL + H", "Move window to left monitor", hl.dsp.window.move({ monitor = "l" }))
rebind("SUPER + SHIFT + CTRL + L", "Move window to right monitor", hl.dsp.window.move({ monitor = "r" }))
rebind("SUPER + SHIFT + ALT + CTRL + H", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
rebind("SUPER + SHIFT + ALT + CTRL + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))

for workspace = 1, 5 do
  rebind(
    "SUPER + SHIFT + CTRL + " .. workspace,
    "Move window silently to workspace " .. workspace,
    hl.dsp.window.move({ workspace = tostring(workspace), follow = false })
  )
end
