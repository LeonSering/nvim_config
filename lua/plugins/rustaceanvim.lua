return {
  'mrcjkb/rustaceanvim', -- lsp configuration for rust
  ft = { 'rust' },
  config = function()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- capabilities.textDocument.completion.completionItem.resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits', } }
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
      },
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>rd', '<cmd> RustLsp openDocs<CR>', { desc = "Rust: Open documentation" })
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
      },
    }
    vim.g.rustaceanvim.dap.autoload_configurations = true
    vim.keymap.set('n', '<leader>bs', '<cmd>RustLsp debug<CR>', { desc = 'Dap: start new debugging session (for rust)' })
  end
}
