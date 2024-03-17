return {
  'kevinhwang91/nvim-hlslens', -- better in page search with / and ?
  dependencies = {
    'petertriho/nvim-scrollbar', -- scrollbar on right side
  },
  priority = 10, -- must be smaller than that of nvim-scrollbar
  config = function()
    require("scrollbar.handlers.search").setup({
      calm_down = true,  -- disable the search highlight when the cursor moves
      nearest_only = true, -- only lens-window for the nearest match
    })

    -- keymapping when starting search
    vim.keymap.set('n', 'n',
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      { silent = true, desc = "Search next" })
    vim.keymap.set('n', 'N',
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      { silent = true, desc = "Search previous" })
    vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]],
      { silent = true, desc = "Search word under cursor forward" })
    vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]],
      { silent = true, desc = "Search word under cursor backward" })
    vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]],
      { silent = true, desc = "Search word under cursor forward" })
    vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]],
      { silent = true, desc = "Search word under cursor backward" })

    -- highlighting
    vim.api.nvim_set_hl(0, 'HlSearchNear',
      { ctermfg = 'green', ctermbg = 'black', fg = 'LightGreen', bg = 'Black', bold = true })
    vim.api.nvim_set_hl(0, 'IncSearch',
      { ctermfg = 'black', ctermbg = 'green', fg = 'Black', bg = 'LightGreen', bold = true })  -- nearest match
    vim.api.nvim_set_hl(0, 'Search',
      { ctermfg = 'black', ctermbg = 'lightgrey', fg = 'Black', bg = 'LightGray', bold = true }) -- other matches
    end
}
