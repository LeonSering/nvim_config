return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  config = function(_, opts)
    -- load fzf-lua with the provided options
    require("fzf-lua").setup {

      winopts = {
        width = 0.95,
        height = 0.9,
        preview = {
          -- hidden = true,            -- hide the preview window by default
          -- layout = "flex",          -- use flex layout for the preview window
          vertical = "down:50%",    -- set the vertical preview height to 50%
          horizontal = "right:50%", -- set the horizontal preview width to 50%
        },
      },

      keymap = {
        builtin = {
          ["<M-Esc>"]    = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
          ["<F1>"]       = "toggle-help",
          ["<F2>"]       = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"]       = "toggle-preview-wrap",
          ["<F4>"]       = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"]       = "toggle-preview-ccw",
          ["<F6>"]       = "toggle-preview-cw",
          -- `ts-ctx` binds require `nvim-treesitter-context`
          ["<F7>"]       = "toggle-preview-ts-ctx",
          ["<F8>"]       = "preview-ts-ctx-dec",
          ["<F9>"]       = "preview-ts-ctx-inc",
          ["<S-Left>"]   = "preview-reset",
          ["<M-S-down>"] = "preview-page-down",
          ["<M-S-up>"]   = "preview-page-up",
          ["<S-down>"]   = "preview-down",
          ["<S-up>"]     = "preview-up",
        },
      },
      files = {
        winopts = {
          -- preview = { hidden = true }
        },
        hidden = false },
      oldfiles = {
        winopts = {
          -- preview = { hidden = true }
        },
        cwd_only = true, -- only show oldfiles from the current working directory
      },
      lsp = {
        jump1 = false,
        symbols = {
          symbol_style = 2,
          symbol_fmt = function(s, _) return s end,
        },
      },
      diagnostics = {
        multiline = false,
        diag_source = false,
        diag_code = false,
        severity_limit = vim.diagnostic.severity.WARN,
        fzf_opts = {
          ["--wrap"] = false,
        }
      },
      fzf_colors = {
        ["bg+"] = { "bg", { "Normal", "Normal" } },
      }
    }

    -- keymaps
    vim.keymap.set('n', '\\', "<cmd>FzfLua resume<cr>", { desc = "FzfLua: Resume" })

    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "FzfLua: Files" })
    vim.keymap.set("n", "<leader>fF", "<cmd>FzfLua files hidden=true no_ignore=true<cr>",
      { desc = "FzfLua: Find files including gitignored and hidden files" })
    vim.keymap.set("n", "<leader>FF", "<cmd>FzfLua files hidden=true no_ignore=true<cr>",
      { desc = "FzfLua: Find files including gitignored and hidden files" })
    vim.keymap.set("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>", { desc = "FzfLua: Old / recent files" })
    vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "FzfLua: Buffers" })
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "FzfLua: Live grep" })

    local function grep_word_under_cursor()
      local word = vim.fn.expand('<cword>')
      require('fzf-lua').live_grep({ query = word })
    end
    vim.keymap.set('n', '<leader>fG', grep_word_under_cursor, { desc = "FzfLua: Live grep word under cursor" })
    vim.keymap.set('n', '<leader>FG', grep_word_under_cursor, { desc = "FzfLua: Live grep word under cursor" })

    local function grep_visual_selection()
      vim.cmd('normal! "zy')
      local search_text = vim.fn.getreg('z')
      search_text = search_text:gsub('\n', ' '):gsub('\r', ' ')
      require('fzf-lua').live_grep({ query = search_text })
    end
    vim.keymap.set('v', '<leader>fg', grep_visual_selection, { desc = "FzfLua: Live grep with selection" })
    vim.keymap.set('v', '<leader>fG', grep_visual_selection, { desc = "FzfLua: Live grep with selection" })
    vim.keymap.set('v', '<leader>FG', grep_visual_selection, { desc = "FzfLua: Live grep with selection" })

    vim.keymap.set('n', '<leader>fw', "<cmd>FzfLua grep_cword<cr>", { desc = "FzfLua: Grep word under cursor" })
    vim.keymap.set('n', '<leader>fu', "<cmd>FzfLua grep_curbuf<cr>",
      { desc = "FzfLua: Fuzzy find in current buffer" })

    vim.keymap.set('n', '<leader>fj', "<cmd>FzfLua jumps<cr>", { desc = "FzfLua: Jumps" })
    vim.keymap.set('n', '<leader>fm', "<cmd>FzfLua marks<cr>", { desc = "FzfLua: Marks" })
    vim.keymap.set('n', '<leader>fr', "<cmd>FzfLua registers<cr>", { desc = "FzfLua: Registers" })
    vim.keymap.set('n', '<leader>f/', "<cmd>FzfLua search_history<cr>", { desc = "FzfLua: Search history" })
    vim.keymap.set('n', '<leader>fc', "<cmd>FzfLua command_history<cr>", { desc = "FzfLua: Commands history" })
    vim.keymap.set('n', '<leader>f:', "<cmd>FzfLua commands<cr>", { desc = "FzfLua: Commands" })
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "FzfLua: Help Tags" })
    vim.keymap.set('n', '<leader>fk', "<cmd>FzfLua keymaps<cr>", { desc = "FzfLua: Keymaps" })

    vim.keymap.set('n', '<leader>fe',
      "<cmd>FzfLua diagnostics_workspace severity_limit=ERROR<cr>",
      { desc = "FzfLua: Errors" })
    vim.keymap.set('n', '<leader>fE', "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "FzfLua: Errors and Warnings" })
    vim.keymap.set('n', '<leader>FE', "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "FzfLua: Errors and Warnings" })
    vim.keymap.set('n', '<leader>fi', "<cmd>FzfLua lsp_incoming_calls<cr>",
      { desc = "FzfLua: LSP incoming calls" })
    vim.keymap.set('n', '<leader>fv', "<cmd>FzfLua lsp_document_symbols<cr>",
      { desc = "FzfLua: LSP document symbols" })
    vim.keymap.set('n', '<leader>fV', "<cmd>FzfLua lsp_workspace_symbols<cr>",
      { desc = "FzfLua: LSP workspace symbols" })
    vim.keymap.set('n', '<leader>FV', "<cmd>FzfLua lsp_workspace_symbols<cr>",
      { desc = "FzfLua: LSP workspace symbols" })
    vim.keymap.set('n', '<leader>fa', function()
      require('fzf-lua').lsp_document_symbols({
        regex_filter = function(item, _)
          if item.kind:match('Struct')
              or item.kind:match('Module')
              or item.kind:match('Class')
              or (item.kind:match('Enum')
                and not item.kind:match('EnumMember'))
              or item.kind:match('Method')
              or item.kind:match('Function')
              or item.kind:match('Namespace')
              or item.kind:match('Package')
              or item.kind:match('Object')
              or item.kind:match('Interface')
              or item.kind:match('File')
          then
            return true
          else
            return false
          end
        end
      })
    end, { desc = "FzfLua: LSP document structure (aerial like)" })

    vim.keymap.set('n', '<leader>fq', "<cmd>FzfLua quickfix<cr>", { desc = "FzfLua: Quickfix" })
    vim.keymap.set('n', '<leader>fs', "<cmd>FzfLua spell_suggest<cr>", { desc = "FzfLua: Spell suggest" })

    vim.keymap.set('n', '<leader>fzc', "<cmd>FzfLua colorschemes<cr>", { desc = "FzfLua: Colorschemes" })
    vim.keymap.set('n', '<leader>fzo', "<cmd>FzfLua nvim_options<cr>", { desc = "FzfLua: Neovim options" })
    vim.keymap.set('n', '<leader>fzh', "<cmd>FzfLua highlights<cr>", { desc = "FzfLua: Highlights" })
    vim.keymap.set('n', '<leader>fza', "<cmd>FzfLua autocmds<cr>", { desc = "FzfLua: Autocommands" })

    vim.keymap.set('n', '<leader>fzz', "<cmd>FzfLua builtin<cr>", { desc = "FzfLua: Builtin" })

    vim.keymap.set('n', '<leader>gl', "<cmd>FzfLua git_bcommits<cr>",
      { desc = "FzfLua: Git log of current file" })

    vim.api.nvim_set_hl(0, 'FzfLuaCursorLine', { link = 'Visual' })
  end,
}
