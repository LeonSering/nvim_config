return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rouge8/neotest-rust",
  },
  -- cargo nextest is required:
  -- curl -LsSf https://get.nexte.st/latest/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rust") {
          -- args = { "--no-capture" },
        },
      },
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = false,
        -- Number of workers to parse files concurrently.
        -- A value of 0 automatically assigns number based on CPU.
        -- Set to 1 if experiencing lag.
        concurrent = 1,
      },
      summary = {
        -- follow = true,
        -- open = "botright vsplit | vertical resize 80",
        mappings = {
          expand = "e",
          expand_all = "E",
          output = "o",
          short = "O",
          attach = "a",
          jumpto = { "<CR>", "<2-LeftMouse>" },
          stop = "u",
          run = "r",
          debug = "d",
          mark = "m",
          run_marked = "R",
          debug_marked = "D",
          clear_marked = "M",
          target = "t",
          clear_target = "T",
          next_failed = "J",
          prev_failed = "K",
          watch = "w",
        },
      },
      output_panel = {
        open = "botright vsplit"
      },
    })


    local function set_fixed_vertical_size_and_nowrap_for_summary()
      vim.cmd('setlocal winfixwidth')
      vim.cmd('vertical resize 60')
      vim.opt_local.wrap = false
    end

    vim.api.nvim_create_autocmd('BufWinEnter', {
      pattern = 'Neotest Summary',
      callback = set_fixed_vertical_size_and_nowrap_for_summary
    })

    local function set_fixed_vertical_size_and_nowrap_for_panel()
      vim.cmd('setlocal winfixwidth')
      vim.cmd('vertical resize 130')
      vim.opt_local.wrap = false
    end
    vim.api.nvim_create_autocmd('BufWinEnter', {
      pattern = 'Neotest Output Panel',
      callback = set_fixed_vertical_size_and_nowrap_for_panel
    })
  end,

  vim.keymap.set('n', '<leader>nt', function()
      require("neotest").output_panel.open()
      require("neotest").run.run()
    end,
    { desc = "Neotest: run test under cursor" }),

  vim.keymap.set('n', '<leader>nf', function()
      require("neotest").output_panel.clear()
      require("neotest").summary.open()
      vim.defer_fn(function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, 500)
    end,
    { desc = "Neotest: run all tests in file" }),


  vim.keymap.set('n', '<leader>na', function()
      require("neotest").output_panel.clear()
      require("neotest").summary.open()
      vim.defer_fn(function()
        require("neotest").run.run({ suite = true })
      end, 1000)
    end,
    { desc = "Neotest: run all test in project" }),

  vim.keymap.set('n', '<leader>ns', function() require("neotest").run.stop() end,
    { desc = "Neotest: stop running tests" }),

  vim.keymap.set('n', '<leader>np', function() require("neotest").output_panel.toggle() end,
    { desc = "Neotest: toggle output panel" }),

  vim.keymap.set('n', '<leader>nn', function() require("neotest").summary.toggle() end,
    { desc = "Neotest: toggle summary panel" }),

  vim.keymap.set('n', '<leader>nw', function() require("neotest").watch.toggle() end,
    { desc = "Neotest: toggle watch for test under cursor" }),

  vim.keymap.set('n', '<leader>nc', function()
      require("neotest").output_panel.clear()
    end,
    { desc = "Neotest: clear ouput panel" }),
}
