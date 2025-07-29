return {
  'andythigpen/nvim-coverage',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("coverage").setup({
      summary = {
        -- customize the summary pop-up
        min_coverage = 80.0,      -- minimum coverage threshold (used for highlighting)
        height_percentage = 0.75, -- height of the summary window
        window = {
          winblend = 0,           -- transparency level
        },
      },
      lang = {
      },
      lcov_file = "target/coverage/lcov.info", -- location of the coverage file

      load_coverage_cb = function(ftype)
        vim.cmd("CoverageShow")
      end,
    })

    vim.api.nvim_set_hl(0, 'CoverageCovered', { ctermfg = 'green', fg = 'Green' })
    vim.api.nvim_set_hl(0, 'CoveragePartial', { ctermfg = 'yellow', fg = 'Yellow' })
    vim.api.nvim_set_hl(0, 'CoverageUncovered', { ctermfg = 'red', fg = 'Red' })

    vim.api.nvim_set_keymap("n", "<leader>rlt", ":CoverageToggle<CR>",
      { desc = "Toggle test coverage signs" })
    vim.api.nvim_set_keymap("n", "<leader>rls", ":CoverageSummary<CR>",
      { desc = "Show test coverage summary" })
    -- Define a function to open a split terminal and run a command

    local function run_cargo_llvm_cov()
      local current_win = vim.api.nvim_get_current_win()
      vim.cmd("rightbelow vnew")
      local terminal_bufnr = vim.api.nvim_get_current_buf()

      local command = 'mkdir -p target/coverage'
          .. ' && cargo llvm-cov --workspace --remap-path-prefix -- --skip systemtest'
          .. ' && cargo llvm-cov report --lcov --output-path target/coverage/lcov.info'
          .. ' && exit' .. '\n'

      -- Start the job in the terminal buffer and attach an on_exit callback
      vim.fn.jobstart(command, {
        on_exit = function(_, exit_code, _)
          if exit_code == 0 then
            -- close terminal
            vim.api.nvim_command("bdelete " .. terminal_bufnr)
            -- load coverage to show sign columns
            vim.cmd('CoverageLoadLcov')
          else
            print("Command failed with exit code: " .. exit_code)
          end
        end,
        stdout_buffered = true,
        stderr_buffered = true,
        term = true,
      })

      -- stay at the end of the terminal buffer
      vim.api.nvim_command("normal! G")

      -- back to the original window
      vim.api.nvim_set_current_win(current_win)

      -- Associate the terminal job ID with the buffer
      -- vim.b[terminal_bufnr].terminal_job_id = job_id
    end

    -- Set the keybinding for <leader>rs
    vim.keymap.set('n', '<leader>rlb', run_cargo_llvm_cov,
      { desc = "Build test coverage (cargo llvm-cov) and show signs" })
  end,
}
