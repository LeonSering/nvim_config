return {
  'f-person/git-blame.nvim', -- git blame
  opts = {
    --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
    message_template = '* <sha> <summary> • <author> • <date>',
    highlight_group = "Question",
    delay = 0,
    vim.api.nvim_set_keymap('n', '<Leader>gb', '<Cmd>GitBlameToggle<CR>', { silent = true }),
  }
}
