return {
  'lewis6991/gitsigns.nvim', -- show git changes in the sign column
  opts = {
    signcolumn = false,      -- Toggle with `:Gitsigns toggle_signs`
    sign_priority = 1000,
    attach_to_untracked = true,
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      map('n', '<leader>gs', '<cmd>Gitsigns toggle_signs<CR>', { desc = 'Toggle git signs' })
      map('n', '<leader>gw', '<cmd>Gitsigns toggle_word_diff<CR>', { desc = 'Toggle git word diff' })
      map('n', '<leader>ga', '<cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage / unstage git hunk' })
      map('v', '<leader>ga', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end,
        { desc = 'Stage / unstage git hunk' })
      map('n', ']g', '<cmd>Gitsigns next_hunk<CR>', { desc = 'Next git hunk' })
      map('n', '[g', '<cmd>Gitsigns prev_hunk<CR>', { desc = 'Previous git hunk' })
    end,
    vim.api.nvim_set_hl(0, 'GitSignsAdd',
      { ctermfg = 'darkgreen', fg = 'DarkGreen', ctermbg = 'none', bg = 'None', bold = true }),
    vim.api.nvim_set_hl(0, 'GitSignsChange',
      { ctermfg = 'darkblue', fg = 'DarkBlue', ctermbg = 'none', bg = 'None', bold = true }),
    vim.api.nvim_set_hl(0, 'GitSignsDelete',
      { ctermfg = 'magenta', fg = 'DarkRed', ctermbg = 'none', bg = 'None', bold = true }),

  }
}
