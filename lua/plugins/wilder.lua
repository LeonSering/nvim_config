return {
  'gelguy/wilder.nvim', -- nice command line completion
  config = function()
    -- config goes here
    local wilder = require('wilder')
    wilder.setup({ modes = { ':', '/', '?' },
    reject_key = {"<Esc>", "<C-c>"} -- for some reason the fallback command <Esc> is like <CR>
  })

    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.cmdline_pipeline(),
        wilder.search_pipeline()
      ),
    })

    wilder.set_option('renderer', wilder.wildmenu_renderer({
      highlighter = wilder.basic_highlighter(),
      highlights = {
        -- selected = wilder.make_hl('WilderAccent', 'Green', 'Black'),
        accent = wilder.make_hl('WilderAccent', 'Pmenu'),
        selected = wilder.make_hl('WilderSelected', 'PmenuSel'),
      }
    }))

    vim.api.nvim_set_hl(0, 'StatusLine', { ctermfg = 'gray', ctermbg = 'black', fg = 'Gray', bg = 'Black' })
  end,
}
