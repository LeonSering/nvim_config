return {
  'chentoast/marks.nvim', -- better marks
  event = "VeryLazy",
  config = function()
    require('marks').setup({
      builtin_marks = { "<", ">", "^", "[", "]" },
      excluded_buftypes = { 'terminal', 'nofile', 'nowrite' },
    })
    vim.api.nvim_set_hl(0, 'MarkSignHl', { ctermbg = 'none', ctermfg = 'gray', bg = 'None', fg = 'Gray', bold = true })
    vim.api.nvim_set_hl(0, 'MarkSignNumHl', { ctermbg = 'none', ctermfg = 'none', bg = 'None', fg = 'None' })
  end
}
