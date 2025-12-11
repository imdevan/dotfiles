-- Docs
-- https://wezterm.org/config/files.html

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Needed for click to open hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- Custom rule for .git URLs - strip the .git extension when opening
table.insert(config.hyperlink_rules, {
	regex = [[(https?://[^\s]+)\.git\b]],
	format = "$1",
})

-- Color Scheme
-- -------------------------------------------------------------------------
-- https://github.com/catppuccin/wezterm
-- function scheme_for_appearance(appearance)
-- 	if appearance:find("Dark") then
-- 		return "Catppuccin Mocha"
-- 	else
-- 		return "Catppuccin Latte"
-- 	end
-- end
-- config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.color_scheme = "Catppuccin Macchiato"

-- Window Styles
-- -------------------------------------------------------------------------
-- https://wezterm.org/config/lua/config/window_decorations.html#window_decorations-title-resize
-- window_decorations = "TITLE | RESIZE | NONE" -- none is same as resize but breaks aerospace
-- config.window_decorations = "RESIZE"
-- config.window_decorations = "RESIZE|MACOS_FORCE_SQUARE_CORNERS"
config.window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW"
-- config.window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW|MACOS_FORCE_SQUARE_CORNERS"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 80
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_frame = {
	border_left_width = "1px",
	border_right_width = "1px",
	border_bottom_height = "1px",
	border_top_height = "1px",
	border_left_color = "#484848",
	border_right_color = "#484848",
	border_bottom_color = "#484848",
	border_top_color = "#484848",
}

-- config.window_frame = {
-- 	border_left_width = "0.2cell",
-- 	border_right_width = "0.2cell",
-- 	border_bottom_height = "0.2cell",
-- 	border_top_height = "0.2cell",
-- 	border_left_color = "purple",
-- 	border_right_color = "purple",
-- 	border_bottom_color = "purple",
-- 	border_top_color = "purple",
-- }
--
-- Wezterm go brrr
-- -------------------------------------------------------------------------
config.max_fps = 240

-- Slow it down for resources if needed
-- config.max_fps = 120
-- config.max_fps = 60 -- default

-- Finally, return the configuration to wezterm:
return config

-- Additional reading
-- https://wezterm.org/config/lua/config/animation_fps.html
-- https://github.com/wezterm/wezterm/issues/6334
-- Consider changing app icon
-- https://github.com/wezterm/wezterm/discussions/2396
