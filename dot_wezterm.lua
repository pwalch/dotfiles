local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local workspace_dir = wezterm.home_dir .. "/workspace"

-- On first window, use workspace dir
config.default_cwd = workspace_dir

config.keys = {
  -- Make OPT-n produce the tilde on Swiss keyboard, otherwise it makes the noise
  {key='n', mods='OPT', action=wezterm.action{SendString="~"}},

  -- Rebind option keys, as by default they give random keys
  {key='1', mods='OPT', action=wezterm.action.DisableDefaultAssignment},
  {key='2', mods='OPT', action=wezterm.action.DisableDefaultAssignment},
  {key='3', mods='OPT', action=wezterm.action{SendString="#"}},
  {key='4', mods='OPT', action=wezterm.action.DisableDefaultAssignment},
  {key='5', mods='OPT', action=wezterm.action{SendString="["}},
  {key='6', mods='OPT', action=wezterm.action{SendString="]"}},
  {key='7', mods='OPT', action=wezterm.action{SendString="|"}},
  {key='8', mods='OPT', action=wezterm.action{SendString="{"}},
  {key='9', mods='OPT', action=wezterm.action{SendString="}"}},
  
  -- Make OPT-LEFT/RIGHT navigate between words
  {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
  {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},

  -- Use workspace dir for all new windows
  {key='n', mods='CMD', action = wezterm.action.SpawnCommandInNewWindow {
    cwd=workspace_dir
  }},

  -- Close current pane or if it's the last pane, close the tab
  {key="w", mods="CMD", action=wezterm.action{CloseCurrentPane={confirm=false}}},

  -- Switch to the next pane
  {key="j", mods="CMD", action=wezterm.action{ActivatePaneDirection="Next"}},

  -- Split panes vertically and horizontally
  {key="l", mods="CMD", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  {key="k", mods="CMD", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},

  -- Open a new tab with the Default profile
  {key="t", mods="CMD", action=wezterm.action{SpawnTab="DefaultDomain"}},

  -- previous/next tab (CMD+OPT+LEFT/RIGHT and CMD-UP/DOWN)
  {key="LeftArrow", mods="OPT|CMD", action=wezterm.action{ActivateTabRelative=-1}},
  {key="RightArrow", mods="OPT|CMD", action=wezterm.action{ActivateTabRelative=1}},
  {key="UpArrow", mods="CMD", action=wezterm.action{ActivateTabRelative=-1}},
  {key="DownArrow", mods="CMD", action=wezterm.action{ActivateTabRelative=1}},

  -- Scroll one line/page up or down
  {key="UpArrow", mods="CMD", action=wezterm.action{ScrollByLine=-1}},
  {key="DownArrow", mods="CMD", action=wezterm.action{ScrollByLine=1}},
  {key="UpArrow", mods="CMD|SHIFT", action=wezterm.action{ScrollByPage=-1}},
  {key="DownArrow", mods="CMD|SHIFT", action=wezterm.action{ScrollByPage=1}},

  -- CTRL-P to activate copy mode, then move around with CTRL-UP/DOWN, then
  -- start selection by pressing "CTRL-O", then "Y" to yank
  {key='p', mods='CTRL', action=wezterm.action.ActivateCopyMode},
  {key='o', mods='CTRL', action=wezterm.action.CopyMode{SetSelectionMode='SemanticZone'}},
  {key='UpArrow', mods='CTRL', action = wezterm.action.CopyMode{MoveBackwardZoneOfType='Prompt'}},
  {key='DownArrow', mods='CTRL', action = wezterm.action.CopyMode{MoveForwardZoneOfType='Prompt'}},

  -- decrease/increase font size using CMD-SHIFT-1/2
  { key = "1", mods = "CMD|SHIFT", action = wezterm.action.IncreaseFontSize },
  { key = "2", mods = "CMD|SHIFT", action = wezterm.action.DecreaseFontSize },

  -- Reload current pane if it got stuck, that is:
  -- split horizontally, switching back to the previous pane, then close it
  {
    key = "r", mods = "CMD", action = wezterm.action_callback(function(window, pane)
      window:perform_action(wezterm.action.SplitHorizontal {domain = "CurrentPaneDomain"}, pane)
      window:perform_action(wezterm.action.ActivatePaneDirection("Prev"), pane)
      window:perform_action(wezterm.action.CloseCurrentPane {confirm = false}, pane)
    end),
  },
}

config.mouse_bindings = {
  -- Select the semantic zone on triple-click
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}

return config
