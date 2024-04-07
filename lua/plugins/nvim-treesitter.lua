return {
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting, deactivated for rust
  build = ':TSUpdate',
  config = function() 
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "lua", "rust", "toml", "json", "yaml", "python", "markdown" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {"rust", "lua"},
      },
      ident = { enable = true },
    }
end
}
