local wezterm = require("wezterm")

-- https://github.com/dragonlobster/wezterm-config/blob/main/wezterm.lua
-- https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono")
config.font_size = 11
config.color_scheme = "Kanagawa (Gogh)"
config.scrollback_lines = 10000

config.warn_about_missing_glyphs = false
config.hide_tab_bar_if_only_one_tab = true

-- config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
   -- top = "0.5cell",
   -- bottom = "0.5cell",
   top = 2,
   bottom = 2,
   left = 2,
   right = 2,
}

return config
