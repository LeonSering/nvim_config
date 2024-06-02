return {
  'smoka7/hop.nvim', -- jump to any word in the buffer
  config = function()
    require("hop").setup({
      multi_windows = true,
      keys = 'weruioasdfjklghcvbnmtp',
    })
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set('n', ';', function()
      hop.hint_char1({ multi_windows = false })
    end, { remap = true })
    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('', 't', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })
    vim.keymap.set('', 'T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true })
  end
}
