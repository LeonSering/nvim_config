return {
  'smoka7/hop.nvim', -- jump to any word in the buffer
  config = function()
    require("hop").setup({
      multi_windows = true,
      keys = 'weruioasdfjklghcvbnmtp',
    })
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set({ 'n', 'x', 'o' }, ';', function()
      hop.hint_char1({ multi_windows = false })
    end, { remap = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true })
  end
}
