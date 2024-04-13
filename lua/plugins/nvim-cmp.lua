return {
  'hrsh7th/nvim-cmp', -- Completion framework
  dependencies = {
    {
      {'L3MON4D3/LuaSnip', build = "make install_jsregexp"}, -- Snippet engine for cmp
      -- dependencies = {
      -- 'rafamadriz/friendly-snippets', -- Snippets for LuaSnip
      -- },
      -- config = function()
      --   require('luasnip.loaders.from_vscode').lazy_load()
      -- end
      'onsails/lspkind.nvim',
    },

    -- Useful completion sources:
    'hrsh7th/cmp-nvim-lsp', -- LSP completion source
    -- 'hrsh7th/cmp-nvim-lsp-signature-help',
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
        -- { name = 'luasnip' },
      },
      window = {
        completion = cmp.config.window.bordered({ col_offset = -1,}),
        documentation = cmp.config.window.bordered(),
      },
      view = {
        entries = { name = 'custom', selection_order = 'near_cursor' }
      },
      formatting = {
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          kind.menu = ""
          vim_item.abbr = vim_item.abbr:gsub('~', '') .. "  " -- Remove the '~' (indicated snippet) from suggestions
          return kind
        end,
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
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
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

    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated',
      { ctermbg = 'none', bg = 'NONE', strikethrough = true, ctermfg = 'gray', fg = 'Gray' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch',
      { ctermbg = 'none', bg = 'NONE', ctermfg = 'yellow', fg = 'Yellow', bold = true })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { ctermbg = 'none', bg = 'NONE', ctermfg = 117, fg = '#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { ctermbg = 'none', bg = 'NONE', ctermfg = 147, fg = '#C586C0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { ctermbg = 'none', bg = 'NONE', ctermfg = 253, fg = '#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
  end
}
