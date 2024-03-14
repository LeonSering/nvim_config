return {
  "kylechui/nvim-surround",
  event = "VeryLazy",  -- surround text with brackets
  opts = {
    surrounds = {
      ["("] = false,
      ["{"] = false,
      ["["] = false,
      ["<"] = false,
    },
    aliases = {
      ["("] = ")",
      ["{"] = "}",
      ["["] = "]",
      ["<"] = ">",
      ["b"] = { ">", ")", "]", "}" },
    },
    vim.keymap.set('n', '<leader>b', '<Plug>(nvim-surround-change)b', { desc = "Surround: Change brackets" }),
    vim.keymap.set('n', '<leader>B', '<Plug>(nvim-surround-change)q', { desc = "Surround: Change quotes" }),
    vim.api.nvim_set_hl(0, 'NvimSurroundHighlight',
      { ctermbg = 'yellow', ctermfg = 'black', bg = 'Yellow', fg = 'Black', bold = true }),
  },
}
