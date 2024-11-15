return
{
  "folke/todo-comments.nvim", -- highlight TODO, NOTE, etc. and activate picker in telegram
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
    keywords = {
      HACK = {
        alt = { "TEMP" },
      },
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*]],
      keyword = "bg",
      after = "",
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]],
    },
    vim.api.nvim_set_hl(0, "TodoBgPERF", { ctermbg = 177, ctermfg = "black", bg = "Violet", fg = "black", }),
    vim.api.nvim_set_hl(0, "TodoBgHACK", { ctermbg = 214, ctermfg = "black", bg = "Orange", fg = "black", }),
    vim.api.nvim_set_hl(0, "TodoBgTODO", { ctermbg = "blue", ctermfg = "black", bg = "Blue", fg = "black", }),
    vim.api.nvim_set_hl(0, "TodoBgNOTE", { ctermbg = 40, ctermfg = "black", bg = "Green3", fg = "black", }),
    vim.api.nvim_set_hl(0, "TodoBgFIX", { ctermbg = "red", ctermfg = "black", bg = "Red", fg = "black", }),
    vim.api.nvim_set_hl(0, "TodoBgWARN", { ctermbg = 214, ctermfg = "black", bg = "Orange1", fg = "black", }),
    vim.api.nvim_set_hl(0, "TodoBgTEST", { ctermbg = "blue", ctermfg = "black", bg = "Blue", fg = "black", }),
    -- PERF
    -- HACK
    -- TODO
    -- NOTE
    -- FIX
    -- WARN
    -- TEST
    -- TEMP

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" }),

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" }),

  }
}
