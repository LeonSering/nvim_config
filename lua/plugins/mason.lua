return {
  {
    'williamboman/mason.nvim', -- package manager for language servers
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {}
  },
  {
    'williamboman/mason-lspconfig.nvim', -- language server configurations
    config = function()
      require('mason-lspconfig').setup({
      automatic_installation = true
    })
      -- vim.cmd("MasonUpdate") -- update language servers on startup
    end
    -- :MasonInstall codelldb
  }
}
