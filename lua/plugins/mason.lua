return {
  {
    'mason-org/mason.nvim', -- package manager for language servers
    opts = {}
  },
  {
    'mason-org/mason-lspconfig.nvim', -- language server configurations
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig'
    },
    config = function()
      require('mason-lspconfig').setup({
        -- Automatically install these language servers
        ensure_installed = {
          'lua_ls',
          'pyright',
          'jsonls',
          'taplo',
          'yamlls',
          'marksman',
          'rust_analyzer',
        },
        -- Automatically set up installed servers with default config
        automatic_installation = true,
      })
    end
  }
}
