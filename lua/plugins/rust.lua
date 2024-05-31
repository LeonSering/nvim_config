return {
  'rust-lang/rust.vim', -- running RustFmt and other short cuts
  ft = { 'rust' },      -- only load for rust files
  config = function()
    -- run RustFmt on the current file only
    -- cargo test and scroll to the bottom of the vim-terminal
    vim.keymap.set('n', '<leader>ct', ':vertical RustTest<CR>G', { desc = "Cargo: Run current test" }) -- run test under cursor
    vim.keymap.set('n', '<leader>cT', ':vertical RustTest!<CR>G', { desc = "Cargo: Run all tests" })   -- run all tests
    vim.keymap.set('n', '<leader>CT', ':vertical RustTest!<CR>G', { desc = "Cargo: Run all tests" })   -- run all tests
    vim.keymap.set('n', '<leader>cr', ':Crun<CR>G', { desc = "Cargo: Run" })
    vim.keymap.set('n', '<leader>cb', ':Cbuild<CR>G', { desc = "Cargo: Build" })
    vim.keymap.set('n', '<leader>cc', ':Cargo clippy<CR>G', { desc = "Cargo: Clippy" })
    vim.g.cargo_shell_command_runner = 'vsplit | terminal' -- open terminal in a vertical split

    vim.g.rustfmt_autosave = 1 -- automatic run :RustFmt on save
  end
}
