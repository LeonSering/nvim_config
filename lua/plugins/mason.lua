return {
  {
    'williamboman/mason.nvim', -- package manager for language servers
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {}
  },
  {
    'williamboman/mason-lspconfig.nvim', -- language server configurations
    opts = {
      automatic_installation = true,
    }
    -- :MasonInstall codelldb
    -- vim.cmd("MasonUpdate") -- update language servers on startup
  }
}
