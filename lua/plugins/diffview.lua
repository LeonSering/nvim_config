return {
  'sindrets/diffview.nvim',
  config = function()
    vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = "Open git DiffviewFileHistory current file" })
    vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<CR>', { desc = "Open git DiffviewFileHistory workking directory" })
    vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = "Open Diffview against current index" })
    vim.keymap.set('n', '<C-c>', '<cmd>DiffviewClose <CR>', { desc = "Close Diffview tab" })
  end
}
