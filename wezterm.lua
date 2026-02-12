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
config.font = wezterm.font {
    family = 'JetBrains Mono',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  }
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
  -- cmd+f for case-insensitive string search
  {
    key = 'f',
    mods = 'CMD',
    action = act.Search { CaseInSensitiveString = '' }
  },
}

config.scrollback_lines = 100000

config.audible_bell = 'Disabled'

-- 启用视觉铃声
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}


local M = {}

local STATE = {
  busy = "busy",
  waiting_input = "waiting_input",
  idle = "idle",
}

-- 检测 Claude 是否在运行
function M.is_claude(pane)
  local process = pane:get_foreground_process_info()
  if not process or not process.argv then
    return false
  end

  for _, arg in ipairs(process.argv) do
    if arg:find("claude") then
      return true
    end
  end
  return false
end

-- 检测 Claude 的当前状态
function M.detect_claude_state(pane)
  local content = pane:get_lines_as_text(1000)
  if not content then
    return STATE.idle
  end

  content = content:lower()

  -- 等待输入状态
  if content:find("│ do you want") or content:find("│ would you like") then
    return STATE.waiting_input
  end

  -- 处理中状态
  if content:find("esc to interrupt") then
    return STATE.busy
  end

  return STATE.idle
end

-- 获取标签页 ID
function M.get_tab_id(window, pane)
  local mux_window = window:mux_window()
  for i, tab_info in ipairs(mux_window:tabs_with_info()) do
    for _, p in ipairs(tab_info.tab:panes()) do
      if p:pane_id() == pane:pane_id() then
        return i
      end
    end
  end
end

-- 在 bell 事件中使用
wezterm.on('bell', function(window, pane)
  if M.is_claude(pane) then
    local state = M.detect_claude_state(pane)
    local tab_id = M.get_tab_id(window, pane)
    local gui_window = window:gui_window()
    if gui_window then
      gui_window:activate()
    end

    if state == STATE.idle then
      -- 任务完成
      window:toast_notification('Claude Code', 'Task completed! (Tab ' .. tab_id .. ')', nil, 4000)
    elseif state == STATE.waiting_input then
      -- 等待用户输入
      window:toast_notification('Claude Code', 'Input needed! (Tab ' .. tab_id .. ')', nil, 4000)
    end
  end
end)

-- Finally, return the configuration to wezterm:
return config
