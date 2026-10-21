-- Control your input devices
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- List of all kb_options: /usr/share/X11/xkb/rules/base.lst
hl.config({
  input = {
    -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt
    -- kb_layout = "us,dk,eu",
    kb_layout = "us",

    -- Swap keys
    -- kb_options = "ctrl:swap_lctl_lshift,caps:swapescape,altwin:swap_alt_win", -- ,grp:alts_toggle
    kb_options = "caps:swapescape",
    -- kb_options = "compose:caps,caps:swapescape,altwin:swap_alt_win", -- ,grp:alts_toggle
    -- kb_options = "caps:swapescape,altwin:swap_alt_win",

    -- Change speed of keyboard repeat
    repeat_rate = 120,
    repeat_delay = 200,
    -- repeat_rate = 40,
    -- repeat_delay = 600,

    -- Start with numlock on by default
    numlock_by_default = true,

    -- General scroll direction and sensitivity
    -- sensitivity = 0.35,
    natural_scroll = true,

    touchpad = {
      -- Use natural (inverse) scrolling
      natural_scroll = true,

      -- Use two-finger clicks for right-click instead of lower-right corner
      -- (Omarchy default is true; old config left this unset = false)
      clickfinger_behavior = false,

      -- Control the speed of your scrolling
      scroll_factor = 0.4,

      -- Enable the touchpad while typing
      -- disable_while_typing = false,

      -- Left-click-and-drag with three fingers
      -- drag_3fg = 1,
    },
  },
})

-- Scroll nicely in the terminal (same as Omarchy's defaults)
o.window("(Alacritty|kitty)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
