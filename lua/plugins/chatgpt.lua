return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    local home = vim.fn.expand("$HOME")
    require("chatgpt").setup({
      api_key_cmd = "cat " .. home .. "/openai_api_key.txt",

      openai_params = {

        -- model = "gpt-3.5-turbo",
        model = "gpt-4o",
        -- https://platform.openai.com/docs/models
      },
      openai_edit_params = {
        model = "gpt-4o",
      },

      edit_with_instructions = {
        keymaps = {
          close = "<esc><esc>",
          accept = "<C-p>",
          toggle_diff = "<C-d>",
          toggle_settings = "<C-o>",
          toggle_help = "<C-h>",
          cycle_windows = "<Tab>",
          use_output_as_input = "<C-r>",
        }
      },
      chat = {
        keymaps = {
          close = "<esc><esc>",
          toggle_system_role_open = "<C-a>",
        }
      },

    })

    require("which-key").add(
      {
        {
          mode = { "n", "v" },
          { "<leader>Aa", "<cmd>ChatGPTRun add_tests<CR>",                 desc = "Add Tests" },
          { "<leader>Ac", "<cmd>ChatGPT<CR>",                              desc = "ChatGPT" },
          { "<leader>Ad", "<cmd>ChatGPTRun docstring<CR>",                 desc = "Docstring" },
          { "<leader>Ae", "<cmd>ChatGPTEditWithInstruction<CR>",           desc = "Edit with instruction" },
          { "<leader>Af", "<cmd>ChatGPTRun fix_bugs<CR>",                  desc = "Fix Bugs" },
          { "<leader>Ag", "<cmd>ChatGPTRun grammar_correction<CR>",        desc = "Grammar Correction" },
          { "<leader>Ak", "<cmd>ChatGPTRun keywords<CR>",                  desc = "Keywords" },
          { "<leader>Al", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
          { "<leader>Ao", "<cmd>ChatGPTRun optimize_code<CR>",             desc = "Optimize Code" },
          { "<leader>As", "<cmd>ChatGPTRun summarize<CR>",                 desc = "Summarize" },
          { "<leader>At", "<cmd>ChatGPTRun translate<CR>",                 desc = "Translate" },
          { "<leader>Ax", "<cmd>ChatGPTRun explain_code<CR>",              desc = "Explain Code" },
        },
        { "<leader>A", group = "ChatGPT", mode = "v" },
      })
  end,

}
