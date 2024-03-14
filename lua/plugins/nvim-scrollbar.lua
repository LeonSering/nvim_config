return {
  'petertriho/nvim-scrollbar', -- scrollbar on right side
  dependecies = {
    'kevinhwang91/nvim-hlslens', -- better in page search with / and ?
  },
  opts = {
    handle = {
      color_nr = 8, -- cterm -- dark grey
    },
    marks = {
      Cursor = { text = "◉", color_nr = 15 },
      Search = { color_nr = 'green', color = 'Green' },
      Error = { color_nr = 'red', color = 'Red' },
      Warn = { color_nr = 'yellow', color = 'Yellow' },
      Info = { color_nr = 'cyan', color = 'Cyan' },
      Hint = { color_nr = 'white', color = 'White' },
      Misc = { color_nr = 'white', color = 'White' },
    },
    handlers = {
      search = true, -- Requires hlslens
    },
  }
}
