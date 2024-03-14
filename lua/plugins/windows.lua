return {
  'anuvyklack/windows.nvim',
  dependencies = {   -- enlarge current window, equal all others
    'anuvyklack/middleclass',
  },
  opts = {
    autowidth = {
      winwidth = 50,   -- width of current window &textwidth + value
    },
    vim.keymap.set({ 'n', 'i', 'v' }, '<A-w>', '<cmd>WindowsMaximize<CR>'),
  }
}

