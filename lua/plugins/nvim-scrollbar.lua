return {
  'petertriho/nvim-scrollbar', -- scrollbar on right side
  priority = 15, -- must be higher than that of nvim-hlslens
  opts = {
    handle = {
      color_nr = 8, -- cterm -- dark grey
    },
    marks = {
      Cursor = { text = "◉", color_nr = 15 },
      Search = { color_nr = 'green', color = 'Green' },
      Error = { color_nr = 'red', color = 'Red' },
      Warn = { color_nr = 214, color = 'Orange' },
      Info = { color_nr = 'cyan', color = 'Cyan' },
      Hint = { color_nr = 'white', color = 'White' },
      Misc = { color_nr = 'white', color = 'White' },
    },
    hide_if_all_visible = true,
    handlers = {
      search = true, -- Requires hlslens
    },
    excluded_buftypes = {
        "terminal",
    },
  }
}
