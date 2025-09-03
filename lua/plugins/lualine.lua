return {
  'nvim-lualine/lualine.nvim', -- statusline at the bottom of the window
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto',
      },
      extensions = { 'nvim-dap-ui', 'aerial' },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          { 'filename', path = 3, color = { fg = 'white' } },
        },
        lualine_c = {
          {
            'diagnostics',
            sections = { 'error', 'warn' },

          },
          {
            function()
              local space = vim.fn.search([[\s\+$]], 'nwc')
              return space ~= 0 and "TW:" .. space or ""
            end,
            color = { fg = 'red' }
          }
        },
        lualine_x = {
          'diff',
        },
        lualine_y = {
          -- 'filetype',
          { 'branch', color = { fg = 'lightgrey' } },
          'encoding',
        },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_b = {
          -- { 'filename', path = 1, color = { fg = 'lightgrey' } },
        },
        lualine_c = {},
        lualine_x = {},
      },
    })
    vim.api.nvim_set_hl(0, 'LuaLineDiffAdd', { ctermfg = 28, fg = 'Green4', bold = true })
    vim.api.nvim_set_hl(0, 'LuaLineDiffChange', { ctermfg = 25, fg = 'DeepSkyBlue4', bold = true })
    vim.api.nvim_set_hl(0, 'LuaLineDiffDelete', { ctermfg = 124, fg = 'Red3', bold = true })
  end
}
