return {
  'chentoast/marks.nvim', -- better marks
  config = function()
    require('marks').setup({

      default_mappings = true, -- whether to map keybinds or not. default true
      -- which builtin marks to show. default {}
      builtin_marks = { "<", ">", "^", "[", "]" },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      mappings = {
        preview = "", -- disable preview
      },
    })
    vim.api.nvim_set_hl(0, 'MarkSignHl', { ctermbg = 'none', ctermfg = 'gray', bg = 'None', fg = 'Gray', bold = true })
    vim.api.nvim_set_hl(0, 'MarkSignNumHl', { ctermbg = 'none', ctermfg = 'none', bg = 'None', fg = 'None' })
  end
}
