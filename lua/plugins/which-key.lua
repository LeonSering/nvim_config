return {
  'folke/which-key.nvim', -- preview keybindings on the bottom if a first key is pressed
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
}
