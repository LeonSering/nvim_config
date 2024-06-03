return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
  config = function()
    require("dapui").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.5,
            },
            {
              id = 'watches',
              size = 0.3,
            },
            {
              id = 'repl',
              size = 0.2,
            },
          },
          position = 'left',
          size = 0.35,
        },
        {
          elements = {
            {
              id = 'console',
              size = 1.0,
            },
          },
          position = 'bottom',
          size = 0.4,
        }
      },
    })


    -- open dapui on some common dap actions
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      vim.cmd.tabedit('%')
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      vim.cmd.tabedit('%')
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
      vim.cmd('tabclose')
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<leader>bp', '<cmd>DapToggleBreakpoint<CR>', { desc = 'Debug: toggle breakpoint' })
    vim.keymap.set('n', '<leader>bs', '<cmd>DapNew<CR>', { desc = 'Debug: start new debugging session' })
    vim.keymap.set('n', '<leader>bt', '<cmd>DapTerminate<CR>', { desc = 'Debug: terminate' })
    vim.keymap.set('n', '<leader>bc', '<cmd>DapContinue<CR>', { desc = 'Debug: continue to next breakpoint' })
    vim.keymap.set('n', '<leader>bn', '<cmd>DapStepOver<CR>', { desc = 'Debug: next step / step over' })
    vim.keymap.set('n', '<leader>bi', '<cmd>DapStepIn<CR>', { desc = 'Debug: step in' })
    vim.keymap.set('n', '<leader>bo', '<cmd>DapStepOut<CR>', { desc = 'Debug: step out' })
    vim.keymap.set('n', '<leader>bu', '<cmd>lua require("dapui").toggle()<CR>', { desc = 'Debug: toggle dap-ui' })
    vim.keymap.set({ 'n', 'i', 'v' }, '<A-c>', function()
        if require("dap").session() then
          require("dap").close();
        end
        vim.cmd('tabclose')
      end,
      { desc = 'Debug: terminate Dap session if active' })

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = 'Red', ctermfg = 'red' })
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakPoint', linehl = '', numhl = '' })

    vim.api.nvim_set_hl(0, 'DapStopped', {bg = 'NavyBlue', ctermbg = 17})
    vim.fn.sign_define('DapStopped', { text = '', linehl = 'DapStopped', numhl = 'DapStopped' })


    require("nvim-dap-virtual-text").setup {
      virt_text_pos = 'eol',
    }

    vim.api.nvim_set_hl(0, 'NvimDapVirtualText', { fg = 'Grey', ctermfg = 'grey' })
  end
}
