return {
  'windwp/nvim-autopairs',
  dependencies = { 'hrsh7th/nvim-cmp' },
  -- for automatically insert parenthesis when choosing function from completion
  config = function()
    require('nvim-autopairs').setup({
    })
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end
}
