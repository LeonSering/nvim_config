return
{
  "ray-x/lsp_signature.nvim",
  -- event = "VeryLazy",
  config = function()
    require 'lsp_signature'.setup({
      max_width = 120,
      floating_window = false,
      hint_enable = false,
      toggle_key = "<C-e>",
      })
  end
}
