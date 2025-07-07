return {
  {
    'mason-org/mason.nvim', -- package manager for language servers
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {}
  },
  {
    'mason-org/mason-lspconfig.nvim', -- language server configurations
    config = function()
      require('mason-lspconfig').setup({
        automatic_enable = false
      })
      -- vim.cmd("MasonUpdate") -- update language servers on startup
    end
    -- :MasonInstall codelldb
  }
}
