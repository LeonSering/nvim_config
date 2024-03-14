return {
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting
  build = ':TSUpdate',
  opts = {
    ensure_installed = { "lua", "rust", "toml", "json", "yaml", "python" },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    ident = { enable = true },
  }
}
