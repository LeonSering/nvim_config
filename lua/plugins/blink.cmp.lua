return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = '*',

  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'accept' },
      -- ['<Esc>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = {
        'snippet_forward', 'select_next',
        function(cmp)
          local col = vim.fn.col('.') - 1
          local line = vim.fn.getline('.')
          if col > 0 and line:sub(col, col):match('[%w%.%:]') then
            cmp.show()
            return true
          end
        end,
        function()
          local termcode = vim.api.nvim_replace_termcodes('<C-T>', true, true, true)
          vim.api.nvim_feedkeys(termcode, 'n', true)
        end,
        'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },


      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['C-d'] = { 'scroll_documentation_down', 'fallback' },

      ['C-e'] = { 'show_documentation', 'hide_documentation' },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      -- default = { 'lsp', 'path', 'buffer' },
      default = { 'lsp' },
      transform_items = function(_, items)
        return vim.tbl_filter(function(item)
          return item.kind ~= require('blink.cmp.types').CompletionItemKind.Snippet
        end, items)
      end
    },

    -- snippets = {
    -- expand = function(snippet)
    -- vim.snippet.expand(snippet)
    -- vim.snippet.stop()
    -- end,
    -- },

    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before *and* after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = { range = 'prefix' },

      -- disable in command line mode
      menu = {
        auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
        border = 'single',
        scrollbar = false,
      },

      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        }
      },

      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = true,
      },

      documentation = {
        auto_show = false,
        -- auto_show_delay_ms = 500,
        window = { border = 'single' },
      }
    },
  },
  opts_extend = { "sources.default" },

  vim.keymap.set({ 'n', 'i', 'v', 's' }, '<A-f>', function()
    vim.snippet.stop()
    if vim.fn.mode() == 's' then
      -- Change from select mode to insert mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>a', true, false, true), 'n', false)
    end
  end),

  vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { link = 'NormalFloat' }),
  vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'NormalFloat' }),
  -- Stop snippets when pressing Esc
  vim.keymap.set({ 'i', 'v', 's' }, '<Esc>', function()
    vim.snippet.stop()
    -- Return to normal mode (equivalent to pressing Esc)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  end, { noremap = true }),

  vim.keymap.set('i', '<Tab>', function()
    -- Check if cursor is within a function parameter using Treesitter
    local node = vim.treesitter.get_node()
    if node and (node:type() == "parameter" or node:parent():type() == "parameter_list") then
      -- Start snippet mode for this parameter
      -- You could use vim.snippet.expand() here with a specific snippet
      return vim.snippet.expand("${1:parameter}")
    else
      -- Normal tab behavior
      return "<Tab>"
    end
  end, { expr = true })
}
