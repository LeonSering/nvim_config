return {
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting and text objects, deactivated for rust
  branch = 'master',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "lua", "rust", "toml", "json", "yaml", "python", "markdown", "markdown_inline", "bash" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = { "rust", "lua" },
      },
      ident = { enable = true },
    }
    vim.cmd('syntax on') -- activate basic regex highlighting as fallback
  end
}
