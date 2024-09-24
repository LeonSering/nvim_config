return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },    -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken",       -- Only on MacOS or Linux
    config = function()
      require("CopilotChat").setup({
        debug = true, -- Enable debugging
        -- default mappings
        prompts = {
          -- Code related prompts
          -- Explain = "Please explain how the following code works.",
          -- Review = "Please review the following code and provide suggestions for improvement.",
          -- Tests = "Please explain how the selected code works, then generate unit tests for it.",
          -- Refactor = "Please refactor the following code to improve its clarity and readability.",
          -- FixCode = "Please fix the following code to make it work as intended.",
          -- FixError = "Please explain the error in the following text and provide a solution.",
          -- BetterNamings = "Please provide better names for the following variables and functions.",
          -- Documentation = "Please provide documentation for the following code.",
          -- SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
          -- SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
          -- Text related prompts
          Summarize = "Please summarize the following text.",
          Spelling = "Please correct any grammar and spelling errors in the following text. Do not add line numbers.",
          Wording = "Please improve the grammar and wording of the following text.",
          CommentFormat =
          "Please format this comment to have no more than 100 characters per line. Do not change the text.",
          -- Concise = "Please rewrite the following text to make it more concise.",
        },
        mappings = {
          close = {
            normal = '<Esc>',
            insert = '<C-c>'
          },
          submit_prompt = {
            normal = '<CR>',
            insert = '<C-CR>'
          },
        },
      })
      vim.keymap.set("n", "<C-C>", "<cmd>CopilotChatToggle<CR>", { desc = "CopilotChat toggle" })
      require("which-key").add(
        {
          {
            mode = { "n", "v" },
            {
              "<leader>Aq",
              function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                  require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                end
              end,
              desc = "CopilotChat - Quick chat (full buffer)",
            },
            { "<leader>Ac", "<cmd>CopilotChatOpen<CR>",          desc = "CopilotChat" },
            { "<leader>Ax", "<cmd>CopilotChatExplain<CR>",       desc = "CopilotChat: Explain Code" },
            { "<leader>Ar", "<cmd>CopilotChatReview<CR>",        desc = "CopilotChat: Review Code" },
            { "<leader>Ao", "<cmd>CopilotChatOptimize<CR>",      desc = "CopilotChat: Optimize Code" },
            { "<leader>Af", "<cmd>CopilotChatFix<CR>",           desc = "CopilotChat: Fix Code" },
            { "<leader>Ae", "<cmd>CopilotChatFixDiagnostic<CR>", desc = "CopilotChat: Fix Diagnostic" },
            { "<leader>At", "<cmd>CopilotChatTests<CR>",         desc = "CopilotChat: Generate Tests" },
            { "<leader>Ad", "<cmd>CopilotChatDocs<CR>",          desc = "CopilotChat: Add Documentation" },
            { "<leader>Ap", "<cmd>CopilotChatCommentFormat<CR>", desc = "CopilotChat: FormatComment to 100 Chars per Line" },
            { "<leader>As", "<cmd>CopilotChatSpelling<CR>",      desc = "CopilotChat: Correct Spelling" },
            { "<leader>Aw", "<cmd>CopilotChatWording<CR>",       desc = "CopilotChat: Improve Wording" },
            { "<leader>Am", "<cmd>CopilotChatSummarize<CR>",     desc = "CopilotChat: Summarize" },
            { "<leader>Ag", "<cmd>CopilotChatCommit<CR>",        desc = "CopilotChat: Write Git Commit Message" },
          },
          { "<leader>A", group = "ChatGPT", mode = "v" },
        })
    end,
  },
}
