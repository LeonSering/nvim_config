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
      hop.hint_words({ multi_windows = true })
    end, { remap = true })
    vim.keymap.set('n', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('n', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('n', 't', function()
      hop.hint_char1({ multi_windows = false })
    end, { remap = true })
    vim.keymap.set('n', 'T', function()
      hop.hint_char1({ multi_windows = true })
    end, { remap = true })
  end
}
