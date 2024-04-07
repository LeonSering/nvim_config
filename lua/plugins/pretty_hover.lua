return {
  "Fildo7525/pretty_hover",
  event = "LspAttach",
  config = function()
    require('pretty_hover').setup({
      toggle = true,
    })
    vim.keymap.set("n", "K", require('pretty_hover').hover, {desc = "LSP: Hover"})
  end,
}
