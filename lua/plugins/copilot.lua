return {
  'github/copilot.vim', -- copilot autocompletion
  config = function()
    -- you must set Return+Ctrl to \E[13;5u in terminal profil to allow this combination
    -- for iterm2, set ^Return (Ctrl+Enter) to "Send Escape Sequence" with value [13;5u in the profile settings
    vim.keymap.set('i', '<C-CR>', 'copilot#Accept("")', { expr = true, replace_keycodes = false })
    vim.keymap.set('i', '<C-p>', '<Plug>(copilot-accept-line)')
    vim.keymap.set('i', '<C-o>', '<Plug>(copilot-accept-word)')
    -- also set:
    -- ^Up to [1;5A  (for Ctrl+Up)
    -- ^Down to [1;5B  (for Ctrl+Down)
    -- ^Right to [1;5C (for Ctrl+Right)
    -- ^Left to [1;5D  (for Ctrl+Left)
    vim.keymap.set('i', '<C-Down>', '<Plug>(copilot-previous)')
    vim.keymap.set('i', '<C-Up>', '<Plug>(copilot-next)')
    vim.keymap.set('i', '<C-Left>', '<Plug>(copilot-dismiss)')
    vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-suggest)')
    vim.g.copilot_no_tab_map = true
    vim.keymap.set('i', '<Tab>', '\t') -- disable tab to accept copilot suggestion
  end
}
