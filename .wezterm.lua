-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 13
config.color_scheme = 'Zenburn'

config.keys = {
  -- activate pane selection mode with numeric labels
  {
    key = '9',
    mods = 'CTRL',
    action = act.PaneSelect {
      alphabet = '1234567890',
    },
  },
  -- show the pane selection mode, but have it swap the active and selected panes
  {
    key = '0',
    mods = 'CTRL',
    action = act.PaneSelect {
      mode = 'SwapWithActive',
    },
  },
}

-- Finally, return the configuration to wezterm:
return config
