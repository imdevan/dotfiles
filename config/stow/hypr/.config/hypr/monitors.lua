-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all
--
-- Monitor eDP-1:    1920x1080@60.01Hz 1920x1080@48.01Hz
-- Monitor HDMI-A-1: 1920x1080@74.99Hz 1920x1080@60.00Hz ... (hyprctl monitors all)

-- Optimized for retina-class 2x displays, like 13" 2.8K, 27" 5K, 32" 6K.
hl.env("GDK_SCALE", "2")
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

hl.monitor({ output = "eDP-1", mode = "1920x1080@60.01", position = "0x0", scale = 1.5 })
-- hl.monitor({ output = "eDP-1", mode = "1920x1080@60.01", position = "0x0", scale = 1.2 })

hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@74.99", position = "auto", scale = 1.2 })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@74.99", position = "auto", scale = 1.2, mirror = "eDP-1" })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60.01", position = "auto", scale = 1.2 })

-- Good compromise for 27" or 32" 4K monitors (but fractional!)
-- hl.env("GDK_SCALE", "1.75")
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.6 })

-- Straight 1x setup for low-resolution displays like 1080p or 1440p
-- hl.env("GDK_SCALE", "1")
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Example for Framework 13 w/ 6K XDR Apple display
-- hl.monitor({ output = "DP-5", mode = "6016x3384@60", position = "auto", scale = 2 })
-- hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "auto", scale = 2 })
