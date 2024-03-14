return {
  'github/copilot.vim', -- copilot autocompletion
  config = function()
    -- you must set Return+Ctrl to \E[13;5u in terminal profil to allow this combination
    vim.keymap.set('i', '<C-CR>', 'copilot#Accept("")', { expr = true, replace_keycodes = false })
    vim.keymap.set('i', '<C-p>', '<Plug>(copilot-accept-line)')
    vim.keymap.set('i', '<C-o>', '<Plug>(copilot-accept-word)')
    vim.keymap.set('i', '<C-Down>', '<Plug>(copilot-previous)')
    vim.keymap.set('i', '<C-Up>', '<Plug>(copilot-next)')
    vim.keymap.set('i', '<C-Left>', '<Plug>(copilot-dismiss)')
    vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-suggest)')
    vim.g.copilot_no_tab_map = true
    vim.keymap.set('i', '<Tab>', '\t') -- disable tab to accept copilot suggestion
  end
}
