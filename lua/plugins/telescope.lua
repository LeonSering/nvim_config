return {
  'nvim-telescope/telescope.nvim',                                  -- fuzzy finder
  priority = 100,
  dependencies = {                                                  -- fuzzy finder
    'nvim-lua/plenary.nvim',
    -- 'nvim-treesitter/nvim-treesitter',                              -- for syntax highlighting
    'nvim-tree/nvim-web-devicons',                                  -- for icons
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- fzf backend,
    -- if fzf not found: Do :Lazy -> Enter on telescope-fzf-native.nvim -> gb to build
  },
  config = function()
    local actions = require("telescope.actions")
    require('telescope').setup {
      defaults = {
        dynamic_preview_title = true,
        layout_config = {
          scroll_speed = 2,
        },
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<Down>"] = "cycle_history_next",
            ["<Up>"] = "cycle_history_prev",
            -- set the following shortcuts to "Send Escape Sequence" in iterm2: in the profile settings:
            -- ^Up to [1;5A  (for Ctrl+Up)
            -- ^Down to [1;5B  (for Ctrl+Down)
            -- ^Right to [1;5C (for Ctrl+Right)
            -- ^Left to [1;5D  (for Ctrl+Left)
            ["<S-Up>"] = "preview_scrolling_up",
            ["<S-Down>"] = "preview_scrolling_down",
            ["<S-Left>"] = "preview_scrolling_left",
            ["<S-Right>"] = "preview_scrolling_right",
            ["<C-h>"] = { "<Left>", type = "command" },
            ["<C-l>"] = { "<Right>", type = "command" },
            ["<C-s>"] = { "<Bs>", type = "command" },
            ["<C-b>"] = { "<C-o>db<Bs>", type = "command" },
            ["<C-u>"] = { "<C-o>d0", type = "command" },
            ["<C-x>"] = { "<Del>", type = "command" },
            ["<C-d>"] = { "<Del>", type = "command" },
            ["<C-w>"] = { "<C-o>dw", type = "command" },
            ["<C-a>"] = { "<C-o>d$", type = "command" },
            ["<C-v>"] = "select_vertical",
          },
          n = {
            ["v"] = "select_vertical",
            ["t"] = "select_tab",
            ["<Down>"] = "cycle_history_next",
            ["<Up>"] = "cycle_history_prev",
            ["<S-Up>"] = "preview_scrolling_up",
            ["<S-Down>"] = "preview_scrolling_down",
            ["<S-Left>"] = "preview_scrolling_left",
            ["<S-Right>"] = "preview_scrolling_right",
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          }
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
        },
      },
    }

    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require("telescope").load_extension("fzf")


    vim.api.nvim_set_hl(0, 'TelescopeMatching', { ctermfg = 'darkyellow', fg = 'Yellow', bold = true }) -- highlight matching text

    vim.keymap.set('n', '<leader>fp', require("telescope").extensions.yank_history.yank_history,
      { desc = "Telescope: Yank history" })

    vim.keymap.set("n", "<leader>ft", "<cmd> TodoTelescope<CR>", { desc = "Telescope: TODOs and NOTEs" })
  end
}
