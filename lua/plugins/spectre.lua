return {
  'nvim-pack/nvim-spectre', -- search and replace
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- for icons
  },
  opts = {
    highlight = { ui = "String", search = "DiffDelete", replace = "DiffAdd" },
    mapping = {
      ['run_current_replace'] = {
        map = "<leader>r",
      },
    },

    vim.keymap.set('n', '<leader>SR', function() require("spectre").open() end, {
      desc = "Spectre: Search and replace in working directory"
    }),
    vim.keymap.set('n', '<leader>SW', function() require("spectre").open_visual({ select_word = true }) end, {
      desc = "Spectre: Search current word in working directory"
    }),
    vim.keymap.set('v', '<leader>SR', 'y<cmd>lua require("spectre").open_visual()<CR>', {
      desc = "Spectre: Search selection in working directory"
    }),
    vim.keymap.set('n', '<leader>sr',
      function() require("spectre").open({ path = vim.fn.fnameescape(vim.fn.expand('%:p:.')) }) end, {
        desc = "Spectre: Search selection in current file (without search text)"
      }),
    vim.keymap.set('n', '<leader>sw', function() require("spectre").open_file_search({ select_word = true }) end, {
      desc = "Spectre: Search current word in current file"
    }),
    vim.keymap.set('v', '<leader>sr', 'y<cmd>lua require("spectre").open_file_search()<CR>', {
      desc = "Spectre: Search selection in current file"
    }),

  },
}
