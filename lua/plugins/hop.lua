return {
  'smoka7/hop.nvim', -- jump to any word in the buffer
  config = function()
    require("hop").setup({
      multi_windows = true
    })
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set('n', ';', function() -- TODO choose different key
      hop.hint_words({ multi_windows = true })
    end, { remap = true })
    vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set('', 't', function()
      hop.hint_char1()
    end, { remap = true })
    vim.keymap.set('', 'T', function()
      hop.hint_char1({ multi_windows = true })
    end, { remap = true })
  end
}
