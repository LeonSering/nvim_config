return {
  'windwp/nvim-autopairs',
  dependencies = { 'hrsh7th/nvim-cmp' },
  event = 'InsertEnter',
  -- for automatically insert parenthesis when choosing function from completion
  config = function()
    require('nvim-autopairs').setup()
    local npairs = require 'nvim-autopairs'
    local Rule = require 'nvim-autopairs.rule'
    local cond = require 'nvim-autopairs.conds'
    local ts_conds = require('nvim-autopairs.ts-conds')
    npairs.clear_rules()
    -- npairs.setup({
      -- check_ts = true,
    -- })
    for _, bracket in pairs { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '"""', '"""' }, { '/*', '*/' } } do
      npairs.add_rules {
        Rule(bracket[1], bracket[2])
            :end_wise(function()
              return true
            end)
      }
    end

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    -- require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())

    local handlers = require('nvim-autopairs.completion.handlers')
    local cmp = require('cmp')

    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done({
        filetypes = {
          -- "*" is a alias to all filetypes
          ["*"] = {
            ["("] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers["*"]
            }
          },
          -- Disable for tex
          tex = false
        }
      })
    )
  end
}
