return {
  'anuvyklack/windows.nvim', -- window management
  dependencies = {   -- enlarge current window, equal all others
    'anuvyklack/middleclass',
  },
  opts = {
    autowidth = {
      winwidth = 30,   -- width of current window &textwidth + value
    },
    vim.keymap.set({ 'n', 'i', 'v' }, '<A-w>', '<cmd>WindowsMaximize<CR>'),
  }
}

