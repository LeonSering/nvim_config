return {
  'numToStr/FTerm.nvim',
  config = function()
    require 'FTerm'.setup({
      border     = 'single',
      dimensions = {
        height = 0.8,
        width = 0.6,
      },
    })

    -- Example keybindings
    vim.keymap.set({'n', 'i'}, '<C-\\>', '<CMD>lua require("FTerm").toggle()<CR>')
    vim.keymap.set('t', '<C-\\>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    vim.keymap.set('t', '<esc>', '<C-\\><C-n><CMD>lua require("FTerm").close()<CR>')
  end
}
