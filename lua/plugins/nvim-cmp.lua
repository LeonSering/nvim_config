return {
  'hrsh7th/nvim-cmp', -- Completion framework
  dependencies = {
    {
      'L3MON4D3/LuaSnip',               -- Snippet engine for cmp
      dependencies = {
        'rafamadriz/friendly-snippets', -- Snippets for LuaSnip
      },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end
    },

    -- Useful completion sources:
    'hrsh7th/cmp-nvim-lsp', -- LSP completion source
    'hrsh7th/cmp-nvim-lsp-signature-help',
    -- 'saadparwaiz1/cmp_luasnip',
  },

  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    cmp.setup({
      -- preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      completion = { autocomplete = false, },

      sources = {
        {
          name = 'nvim_lsp',
          entry_filter = function(entry, ctx)
            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Snippet'
          end
        }, -- from language server
        { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
        -- { name = 'luasnip' },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      view = {
        entries = { name = 'custom', selection_order = 'bottom_up' }
      },
      mapping = {
        ['<C-j>'] = function(fallback)
          if cmp.visible() then
            if cmp.core.view.custom_entries_view:is_direction_top_down() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            end
          else
            fallback()
          end
        end,
        ['<C-k>'] = function(fallback)
          if cmp.visible() then
            if cmp.core.view.custom_entries_view:is_direction_top_down() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
          else
            fallback()
          end
        end,
        ['<C-S-j>'] = cmp.mapping.scroll_docs(-4),
        ['<C-S-k>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = function()
          if cmp.visible() then
            cmp.confirm()
          else
            cmp.complete()
          end
        end,
        ['<Esc>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if cmp.core.view.custom_entries_view:is_direction_top_down() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            end
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if cmp.core.view.custom_entries_view:is_direction_top_down() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' })
      },
    })
    vim.opt.pumheight = 10 -- limit the number of suggestions
  end
}
