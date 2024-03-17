return {
  'numToStr/Comment.nvim', -- for commentary
  config = function()
    require('Comment').setup({
      mappings = {
        basic = false,
        extra = false,
      }
    })
    vim.keymap.set('n', '<C-k>', '<Plug>(comment_toggle_linewise_current)<up>')
    vim.keymap.set('n', '<C-j>', '<Plug>(comment_toggle_linewise_current)<down>')
    vim.keymap.set('v', '<C-k>', '<Plug>(comment_toggle_linewise_visual)<up>')
    vim.keymap.set('v', '<C-j>', '<Plug>(comment_toggle_linewise_visual)<down>')
    -- set Ctrl + / to toggle comment
    vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)')
    vim.keymap.set('i', '<C-_>', '<C-o><Plug>(comment_toggle_linewise_current)')
    vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_blockwise_visual)')
    -- disable auto comment on <CR>. <Esc>o can be used for new line with comment
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = '*',
      callback = function()
        vim.opt.formatoptions:remove({ 'r' })
      end
    })
    -- set Shift+Enter to new line with comment
    -- set Return+Shift to \E[13;2u in terminal profil to allow this combination
    vim.keymap.set('i', '<S-CR>', '<Esc>o')
  end
}
