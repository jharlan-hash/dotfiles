local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha (Gogh)'

config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font "FiraCode Nerd Font"
config.window_background_opacity = 0.9

--config.window_decorations = "NONE"

return config
