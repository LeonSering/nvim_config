return {
  "smjonas/inc-rename.nvim",
  opts = {
    vim.keymap.set("n", "<leader>rn", function()
      return ":Rename " .. vim.fn.expand("<cword>")
    end, { expr = true }),
    cmd_name = "Rename",
  },
}
