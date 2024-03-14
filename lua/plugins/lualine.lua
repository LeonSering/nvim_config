return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    -- options = {theme = 'papercolor_dark'},
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        { 'filename', path = 1, color = { fg = 'lightgrey' } },
      },
      lualine_x = {
        {
          function()
            local space = vim.fn.search([[\s\+$]], 'nwc')
            return space ~= 0 and "TW:" .. space or ""
          end,
          color = { fg = 'red' }
        },
        'encoding',
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_c = {
        { 'filename', path = 1, color = { fg = 'lightgrey' } },
      },
      lualine_x = {},
    },
  }
}
