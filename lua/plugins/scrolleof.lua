return {
  'Aasim-A/scrollEOF.nvim', -- always show lines below coursor (including at EOF)
  event = { 'CursorMoved', 'WinScrolled' },
  config = function()
    vim.opt.scrolloff = 6
    require('scrollEOF').setup({
      insert_mode = true,
      floating = false,
    })
  end,
}
