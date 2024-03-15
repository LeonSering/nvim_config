return {
  'L3MON4D3/LuaSnip',     -- Snippet engine for cmp

  -- Useful completion sources:
  'hrsh7th/cmp-nvim-lsp', -- LSP completion source
  'hrsh7th/cmp-nvim-lua', -- for editing this init.lua file
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lsp-document-symbol',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  {
    'hrsh7th/nvim-cmp', -- Completion framework

    config = function()
      --Set completeopt to have a better completion experience
      -- :help completeopt
      -- menuone: popup even when there's only one match
      -- noinsert: Do not insert text until a selection is made
      -- noselect: Do not select, force to select one from the menu
      -- shortness: avoid showing extra messages when using completion
      -- updatetime: set updatetime for CursorHold
      require("luasnip.loaders.from_vscode").lazy_load()
      -- vim.opt.completeopt = {'menuone', 'noinsert'}
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
      vim.opt.shortmess = vim.opt.shortmess + { c = true }
      -- vim.api.nvim_set_option('updatetime', 300)
      -- Completion Plugin Setup
      local cmp = require('cmp')
      cmp.setup({
        completion = {
          autocomplete = false, -- no automatic popup
        },
        -- Enable LSP snippets
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
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
          -- Add tab support
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
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
        },
        -- Installed sources:
        sources = {
          { name = 'path' },                                      -- file paths
          { name = 'nvim_lsp' },                                  -- from language server
          { name = 'nvim_lsp_signature_help' },                   -- display function signatures with current parameter emphasized
          { name = 'nvim_lsp_document_symbol' },                  -- document symbols
          { name = 'nvim_lua',                keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
          { name = 'buffer',                  keyword_length = 2 }, -- source current buffer
          { name = 'luasnip',                 keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
          { name = 'calc' },                                      -- source for math calculation
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        view = {
          entries = { name = 'custom', selection_order = 'bottom_up' }
        },
      })
      vim.opt.pumheight = 10 -- limit the number of suggestions
    end
  }
}
