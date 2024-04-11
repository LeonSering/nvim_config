return {
  "ErichDonGubler/lsp_lines.nvim", -- show diagnostics between lines
  config = function()
    require("lsp_lines").setup()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false
    })
    vim.keymap.set('n', '<leader>l', require("lsp_lines").toggle, { desc = "Toggle LSP lines" })
  end
}
