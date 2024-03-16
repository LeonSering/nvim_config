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
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp', -- LSP completion source
    -- 'hrsh7th/cmp-nvim-lua', -- for editing this init.lua file
    -- 'hrsh7th/cmp-nvim-lsp-signature-help',
    -- 'hrsh7th/cmp-nvim-lsp-document-symbol',
    -- 'hrsh7th/cmp-path',
    -- 'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-vsnip',
    -- 'hrsh7th/vim-vsnip',
  },

  config = function()
    --Set completeopt to have a better completion experience
    -- :help completeopt
    -- menuone: popup even when there's only one match
    -- noinsert: Do not insert text until a selection is made
    -- noselect: Do not select, force to select one from the menu
    -- shortness: avoid showing extra messages when using completion
    -- updatetime: set updatetime for CursorHold
    -- local luasnip = require('luasnip')
    -- luasnip.config.setup {}

    -- require("luasnip.loaders.from_vscode").lazy_load()
    -- vim.opt.completeopt = {'menuone', 'noinsert'}
    -- vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
    -- vim.opt.shortmess = vim.opt.shortmess + { c = true }
    -- vim.api.nvim_set_option('updatetime', 300)
    -- Completion Plugin Setup
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    cmp.setup({
      snippet = {
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      completion = { autocomplete = false, },
      -- completion = { completeopt = 'menu,menuone,noinsert' },

      sources = {
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'vsnip-integ' },    -- For vsnip users.
        -- { name = 'path' },                                      -- file paths
        { name = 'nvim_lsp' }, -- from language server
        -- { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
        -- { name = 'nvim_lsp_document_symbol' },                  -- document symbols
        -- { name = 'nvim_lua',                keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        -- { name = 'buffer',                  keyword_length = 2 }, -- source current buffer
        { name = 'luasnip' },
        -- { name = 'calc' },                                      -- source for math calculation
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
        -- Add tab support
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        -- ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
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
        ['<Tab>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
        -- ['<C-l>'] = cmp.mapping(function()
          -- if luasnip.expand_or_locally_jumpable() then
            -- luasnip.expand_or_jump()
          -- end
        -- end, { 'i', 's' }),
        -- ['<C-h>'] = cmp.mapping(function()
          -- if luasnip.locally_jumpable(-1) then
            -- luasnip.jump(-1)
          -- end
        -- end, { 'i', 's' }),
      },
    })
    vim.opt.pumheight = 10 -- limit the number of suggestions
  end
}
