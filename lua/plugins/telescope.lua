return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  priority = 100,
  dependencies = {                                                  -- fuzzy finder
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',                              -- for syntax highlighting
    'nvim-tree/nvim-web-devicons',                                  -- for icons
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- fzf backend,
    -- if fzf not found: Do :Lazy -> Enter on telescope-fzf-native.nvim -> gb to build
  },
  config = function()
    require('telescope').setup {
      defaults = {
        dynamic_preview_title = true,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-Down>"] = "cycle_history_next",
            ["<C-Up>"] = "cycle_history_prev",
            ["<C-h>"] = { "<Left>", type = "command" },
            ["<C-l>"] = { "<Right>", type = "command" },
            ["<C-s>"] = { "<Bs>", type = "command" },
            ["<C-b>"] = { "<C-o>db<Bs>", type = "command" },
            ["<C-u>"] = { "<C-o>d0", type = "command" },
            ["<C-x>"] = { "<Del>", type = "command" },
            ["<C-w>"] = { "<C-o>dw", type = "command" },
            ["<C-a>"] = { "<C-o>d$", type = "command" },
            ["<C-v>"] = "select_vertical",
          },
          n = {
            ["v"] = "select_vertical",
            ["t"] = "select_tab",
            ["<C-Down>"] = "cycle_history_next",
            ["<C-Up>"] = "cycle_history_prev",
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
        lsp_workspace_symbols = {
          initial_mode = "insert",
          fname_width = 0.4,
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
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        }
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
    vim.keymap.set('n', '<leader>fz', builtin.builtin, { desc = "Telescope: Builtin" })
    vim.keymap.set('n', '<leader>fzc', builtin.colorscheme, { desc = "Telescope: Colorscheme" })
    vim.keymap.set('n', '<leader>fzo', builtin.vim_options, { desc = "Telescope: Vim options" })
    vim.keymap.set('n', '<leader>fzh', builtin.highlights, { desc = "Telescope: Highlights" })
    vim.keymap.set('n', '<leader>fza', builtin.autocommands, { desc = "Telescope: Autocommands" })

    vim.keymap.set('n', '<leader>fe', builtin.diagnostics, { desc = "Telescope: Diagnostics" })
    vim.keymap.set('n', '<leader>fv', builtin.lsp_document_symbols, { desc = "Telescope: LSP document symbols" })
    vim.keymap.set('n', '<leader>fV', builtin.lsp_workspace_symbols, { desc = "Telescope: LSP workspace symbols" })
    vim.keymap.set('n', '<leader>FV', builtin.lsp_workspace_symbols, { desc = "Telescope: LSP workspace symbols" })

    vim.keymap.set('n', '<leader>gl', builtin.git_bcommits, { desc = "Telescope: Git log of current file" })
    require("telescope").load_extension("aerial")
    vim.keymap.set('n', '<leader>fa', require("telescope").extensions.aerial.aerial, { desc = "Telescope: Aerial" })
  end
}
