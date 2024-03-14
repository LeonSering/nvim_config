return {
  'rust-lang/rust.vim', -- running RustFmt and other short cuts
  config = function()
    -- run RustFmt on the current file only
    -- cargo test and scroll to the bottom of the vim-terminal
    vim.keymap.set('n', '<leader>ct', ':RustTest<CR>G', { desc = "Cargo: Run current test" }) -- run test under cursor
    vim.keymap.set('n', '<leader>cT', ':RustTest!<CR>G', { desc = "Cargo: Run all tests" }) -- run all tests
    vim.keymap.set('n', '<leader>CT', ':RustTest!<CR>G', { desc = { "Cargo: Run all tests" } }) -- run all tests

    -- cargo run and scroll to the bottom of the vim-terminal
    vim.keymap.set('n', '<leader>cr', ':Crun<CR>G', { desc = "Cargo: Run" })
    -- cargo build and scroll to the bottom of the vim-terminal
    vim.keymap.set('n', '<leader>cb', ':Cbuild<CR>G', { desc = "Cargo: Build" })
    vim.g.rustfmt_autosave = 1 -- automatic run :RustFmt on save
  end
}
