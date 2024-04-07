return {
  'mrcjkb/rustaceanvim',
  -- version = '^4', -- Recommended
  ft = { 'rust' },
  config = function()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- capabilities.textDocument.completion.completionItem.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits', } }
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
      },
      -- capabilities = capabilities,
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>cd', '<cmd> RustLsp openDocs<CR>', { desc = "Rust: Open documentation" })
          -- vim.keymap.set('n', '<leader>e', require('rustaceanvim.commands.diagnostic').render_diagnostic, { desc = "Rust: Render diagnostics" })
          -- vim.keymap.set('n', '<leader>e', '<cmd> RustLsp renderDiagnostic<CR>', { desc = "Rust: Render diagnostics" })
          -- vim.keymap.set('n', '<leader>e', '<cmd> RustLsp explainError<CR>', { desc = "Rust: Explain error" })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      },
      -- DAP configuration
      dap = {
      }
    }
  end
}
