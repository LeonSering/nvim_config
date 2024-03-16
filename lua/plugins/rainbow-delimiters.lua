return {
  'HiPhish/rainbow-delimiters.nvim', -- rainbow brackets
  config = function()
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = require('rainbow-delimiters').strategy['global'],
      },
      highlight = {
        -- 'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange', -- cterm is white
        'RainbowDelimiterGreen',
        -- 'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
  end
}
