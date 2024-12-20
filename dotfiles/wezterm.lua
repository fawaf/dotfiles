-- Pull in the wezterm API
local wezterm = require 'wezterm'
local theme = require 'theme'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 13.0

-- and finally, return the configuration to wezterm
return config
