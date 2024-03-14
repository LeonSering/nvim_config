return {
  'lewis6991/gitsigns.nvim', -- show git changes in the sign column
  opts = {
    signcolumn = false,      -- Toggle with `:Gitsigns toggle_signs`
    sign_priority = 1000,
    attach_to_untracked = true,
    on_attach = function(bufnr)
      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end
      map('n', '<leader>gs', '<cmd>Gitsigns toggle_signs<CR>')
      map('n', '<leader>gw', '<cmd>Gitsigns toggle_word_diff<CR>')
    end,
    vim.api.nvim_set_hl(0, 'GitSignsAdd',
      { ctermfg = 'darkgreen', fg = 'DarkGreen', ctermbg = 'none', bg = 'None', bold = true }),
    vim.api.nvim_set_hl(0, 'GitSignsChange',
      { ctermfg = 'darkblue', fg = 'DarkBlue', ctermbg = 'none', bg = 'None', bold = true }),
    vim.api.nvim_set_hl(0, 'GitSignsDelete',
      { ctermfg = 'magenta', fg = 'DarkRed', ctermbg = 'none', bg = 'None', bold = true }),

  }
}
