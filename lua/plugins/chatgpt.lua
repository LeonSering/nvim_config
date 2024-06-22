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
    require("chatgpt").setup({
      api_key_cmd = "cat /home/leon/openai_api_key.txt",

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

    local wk = require("which-key")
    wk.register({
      A = {
        name = "ChatGPT",
        c = { "<cmd>ChatGPT<CR>", "ChatGPT", mode = { "n", "v" } },
        e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
        g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
        t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
        k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
        d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
        a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
        o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
        s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
        f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
        x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
        -- r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
        l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
      },
    }, {
      prefix = "<leader>",
      mode = "v",
    })
  end,

}
