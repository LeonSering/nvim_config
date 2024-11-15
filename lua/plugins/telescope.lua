return {
  'nvim-telescope/telescope.nvim',                                  -- fuzzy finder
  priority = 100,
  dependencies = {                                                  -- fuzzy finder
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',                              -- for syntax highlighting
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
            ["<C-Up>"] = "preview_scrolling_up",
            ["<C-Down>"] = "preview_scrolling_down",
            ["<C-Left>"] = "preview_scrolling_left",
            ["<C-Right>"] = "preview_scrolling_right",
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
            ["<C-Up>"] = "preview_scrolling_up",
            ["<C-Down>"] = "preview_scrolling_down",
            ["<C-Left>"] = "preview_scrolling_left",
            ["<C-Right>"] = "preview_scrolling_right",
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          }
        },
      },
      pickers = {
        find_files = {
          initial_mode = "insert",
          theme = "dropdown",
          previewer = false,
          layout_config = {
            width = 0.5,
            height = 0.8,
          },
          no_ignore = false,
          hidden = false,
        },
        oldfiles = {
          theme = "dropdown",
          previewer = false,
          cwd_only = true,
          layout_config = {
            width = 0.5,
            height = 0.8,
          },
        },
        live_grep = {
          initial_mode = "insert",
        },
        current_buffer_fuzzy_find = {
          initial_mode = "insert",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          layout_config = {
            width = 0.5,
            height = 0.8,
          },
        },
        registers = {
          previewer = true
        },
        help_tags = {
          initial_mode = "insert",
          mappings = {
            i = {
              ["<CR>"] = "select_vertical",
            },
            n = {
              ["<CR>"] = "select_vertical",
            },
          },
        },
        commands = {
          initial_mode = "insert",
        },
        keymaps = {
          initial_mode = "insert",
        },
        builtin = {
          initial_mode = "insert",
        },
        vim_options = {
          initial_mode = "insert",
        },
        highlights = {
          initial_mode = "insert",
        },
        autocommands = {
          initial_mode = "insert",
        },
        diagnostics = {
          severity_limit = "Warn", -- only show warnings and errors
        },
        lsp_document_symbols = {
          initial_mode = "insert",
          symbol_width = 0.6,
        },
        lsp_workspace_symbols = {
          initial_mode = "insert",
          fname_width = 0.4,
        },
        lsp_type_definitions = {
          jump_type = "never",
          path_display = { "tail" },
        },
        lsp_incoming_calls = {
          jump_type = "never",
        },
        lsp_references = {
          jump_type = "never",
        },
        git_bcommits = {
          mappings = {
            i = {
              ["<CR>"] = "select_vertical",
            },
            n = {
              ["<CR>"] = "select_vertical",
            },
          },
        }

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

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '\\', builtin.resume, {})
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope: Find files" })
    vim.keymap.set('n', '<leader>FF',
      '<cmd> lua require("telescope.builtin").find_files({hidden = true, no_ignore = true})<CR>',
      { desc = "Telescope: Find files including gitignored and hidden files" })
    vim.keymap.set('n', '<leader>fF',
      '<cmd> lua require("telescope.builtin").find_files({hidden = true, no_ignore = true})<CR>',
      { desc = "Telescope: Find files including gitignored and hidden files" })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Telescope: Open old / recent files" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope: Live grep" })
    vim.keymap.set('n', '<leader>fu', builtin.current_buffer_fuzzy_find,
      { desc = "Telescope: Fuzzy find in current buffer" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope: Buffers" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope: Help tags" })
    vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = "Telescope: Command history" })
    vim.keymap.set('n', '<leader>f/', builtin.search_history, { desc = "Telescope: Search history" })
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = "Telescope: Marks" })
    vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = "Telescope: Registers" })
    vim.keymap.set('n', '<leader>fp', require("telescope").extensions.yank_history.yank_history,
      { desc = "Telescope: Yank history" })
    vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "Telescope: Jump list" })
    vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = "Telescope: Quickfix" })
    vim.keymap.set('n', '<leader>f:', builtin.commands, { desc = "Telescope: Commands" })
    vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = "Telescope: Spell suggest" })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Telescope: Keymaps" })
    vim.keymap.set("n", "<leader>ft", "<cmd> TodoTelescope<CR>", { desc = "Telescope: TODOs and NOTEs" })
    vim.keymap.set('n', '<leader>fzz', builtin.builtin, { desc = "Telescope: Builtin" })
    vim.keymap.set('n', '<leader>fzc', builtin.colorscheme, { desc = "Telescope: Colorscheme" })
    vim.keymap.set('n', '<leader>fzo', builtin.vim_options, { desc = "Telescope: Vim options" })
    vim.keymap.set('n', '<leader>fzh', builtin.highlights, { desc = "Telescope: Highlights" })
    vim.keymap.set('n', '<leader>fza', builtin.autocommands, { desc = "Telescope: Autocommands" })

    vim.keymap.set('n', '<leader>fe', builtin.diagnostics, { desc = "Telescope: Diagnostics" })
    vim.keymap.set('n', '<leader>fv', builtin.lsp_document_symbols, { desc = "Telescope: LSP document symbols" })
    vim.keymap.set('n', '<leader>fV', builtin.lsp_workspace_symbols, { desc = "Telescope: LSP workspace symbols" })
    vim.keymap.set('n', '<leader>FV', builtin.lsp_workspace_symbols, { desc = "Telescope: LSP workspace symbols" })

    vim.keymap.set('n', '<leader>t', builtin.lsp_type_definitions, { desc = "Telescope: LSP type definitions" })
    vim.keymap.set('n', '<leader>i', builtin.lsp_incoming_calls, { desc = "Telescope: LSP incoming calls" })
    vim.keymap.set('n', '<leader>u', builtin.lsp_references, { desc = "Telescope: LSP References" })

    vim.keymap.set('n', '<leader>gl', builtin.git_bcommits, { desc = "Telescope: Git log of current file" })
    require("telescope").load_extension("aerial")
    vim.keymap.set('n', '<leader>fa',
      '<cmd> lua require("telescope").extensions.aerial.aerial({initial_mode="insert"})<CR>',
      { desc = "Telescope: Aerial" })
  end
}
