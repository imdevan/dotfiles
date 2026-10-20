-- Window rules, loaded from hyprland.lua after Omarchy's defaults.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--
-- Already covered by Omarchy's defaults ($OMARCHY_PATH/default/hypr/windows.lua):
--   suppress_event maximize on all windows, and the XWayland dragging no_focus fix.

-- Full opacity by default. Omarchy applies "0.985 0.96" to the default-opacity
-- tag, so override that same tag (apps that opt out of the tag stay untouched).
o.window({ tag = "default-opacity" }, { opacity = "1 0.9" })
-- o.window({ tag = "default-opacity" }, { opacity = "0.98 0.6" })
-- o.window({ tag = "default-opacity" }, { opacity = "0.94 0.88" })
-- o.window({ tag = "default-opacity" }, { opacity = "0.9 0.6" })
-- o.window({ tag = "default-opacity" }, { opacity = "0.84 0.48" })

-- o.window("org.qutebrowser.qutebrowser", { opacity = "0.9 0.8" })
-- o.window("chromium", { opacity = "1 1" })
-- o.window("com.mitchellh.ghostty", { opacity = "0.94 0.88", no_blur = true })
-- o.window("com.mitchellh.ghostty", { opacity = "0.8 0.5", no_blur = true })
-- o.window("li.oever.aether", { opacity = "1 0.8" }) -- keep aether fully opaque for theming clarity
-- o.window("kitty", { opacity = "0.84 0.5" })
-- o.window({ tag = "default-opacity" }, { opacity = "0.94 0.88" })

-- Clients for reference
--
-- Chromium:
-- 	class: chromium
--
-- terminal:
-- 	class: com.mitchellh.ghostty
-- 	title: t
--
-- qutebrowser:
-- 	class: org.qutebrowser.qutebrowser
-- 	title: Lovable App - qutebrowser
--
-- Aether:
-- 	class: li.oever.aether
-- 	title: Aether
