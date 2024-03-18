return
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*]],
      keyword = "bg",
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]],
    },
    vim.api.nvim_set_hl(0, "TodoBgPERF", {
      ctermbg = 177,
      ctermfg = "black",
      bg = "Violet",
      fg = "black",
      bold = true
    }),
    vim.api.nvim_set_hl(0, "TodoBgHACK", {
      ctermbg = 214,
      ctermfg = "black",
      bg = "Orange1",
      fg = "black",
      bold = true
    }),
    vim.api.nvim_set_hl(0, "TodoBgTODO", {
      ctermbg = "blue",
      ctermfg = "black",
      bg = "Blue",
      fg = "black",
      bold = true
    }),
    vim.api.nvim_set_hl(0, "TodoBgNOTE", {
      ctermbg = 40,
      ctermfg = "black",
      bg = "Green3",
      fg = "black",
      bold = true
    }),
    vim.api.nvim_set_hl(0, "TodoBgFIX", {
      ctermbg = "red",
      ctermfg = "black",
      bg = "Red",
      fg = "black",
      bold = true
    }),
    vim.api.nvim_set_hl(0, "TodoBgWARN", {
      ctermbg = "yellow",
      ctermfg = "black",
      bg = "Yellow",
      fg = "black",
      bold = true
    }),
    vim.api.nvim_set_hl(0, "TodoBgTEST", {
      ctermbg = "blue",
      ctermfg = "black",
      bg = "Blue",
      fg = "black",
      bold = true
    }),
    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" }),

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" }),

    vim.keymap.set("n", "<leader>ft", "<cmd> TodoTelescope<CR>", { desc = "Telescope: TODOs and NOTEs" }),
  }
}
