require('smart-splits').setup({
  ignore_bufter_types = {
    'terminal',
    'nofile',
    'quickfix',
    'prompt',
  },
  ignored_filetypes = { 'NvimTree' },
  default_amount = 3,
  at_edge = 'wrap',
  float_win_behavior = 'previous',
  move_cursor_same_row = true,
  cursor_follows_swapped_bufs = false,
  resize_mode = {
    quit_key = '<ESC>',
    resize_keys = { 'h', 'j', 'k', 'l' },
    silent = false,
    hooks = {
      on_enter = function()
        vim.notify('Entering resize mode')
      end,
      on_leave = require('bufresize').register

    },
  },
  ignored_events = {
    'BufEnter',
    'WinEnter',
  },
  multiplexer_integration = nil,
  disable_multiplexer_nav_when_zoomed = true,
  kitty_password = nil,
  log_level = 'info',
})
