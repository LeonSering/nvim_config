return {
  'mrcjkb/rustaceanvim', -- lsp configuration for rust
  dependencies = 'neovim/nvim-lspconfig',
  ft = { 'rust' },
  config = function()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- capabilities.textDocument.completion.completionItem.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits', } }
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        float_win_config = {
          border = 'single'
        }
      },
      -- LSP configuration
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>rd', '<cmd> RustLsp openDocs<CR>', { desc = "Rust: Open documentation" })
          vim.keymap.set('n', '<leader>bs', '<cmd>RustLsp debug<CR>',
            { desc = 'Dap: start new debugging session (for rust)' })
          vim.keymap.set('n', '<leader>e', '<cmd>RustLsp renderDiagnostic cycle<CR>',
            { desc = 'Rust: Render next diagnostics' })
          vim.keymap.set('n', '<leader>E', '<cmd>RustLsp renderDiagnostic current<CR>',
            { desc = 'Rust: Render current diagnostics' })
          vim.keymap.set('n', '<leader>re', '<cmd>RustLsp explainError cycle<CR>', { desc = "Rust: Explain next error" })
          vim.keymap.set('n', '<leader>rE', '<cmd>RustLsp explainError current<CR>',
            { desc = "Rust: Explain previous error" })
          vim.keymap.set('n', '<leader>RE', '<cmd>RustLsp explainError current<CR>',
            { desc = "Rust: Explain previous error" })

          vim.keymap.set('n', '<leader>rj', '<cmd>RustLsp moveItem down<CR>', { desc = 'Rust: Move item down' })
          vim.keymap.set('n', '<leader>rk', '<cmd>RustLsp moveItem up<CR>', { desc = "Rust: Move item up" })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            rustfmt = {
              extraArgs = { "+nightly", "--config-path=/Users/leon.sering/rustfmt.toml" },
            },
            checkOnSave = {
              command = 'clippy',
            },
            imports = {
              granularity = {
                group = "module",
              },
            },
          },
        },
      },
      -- DAP configuration
      dap = {
      },
    }
    vim.g.rustaceanvim.dap.autoload_configurations = true
  end
}
