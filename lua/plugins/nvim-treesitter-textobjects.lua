return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require 'nvim-treesitter.configs'.setup {
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { query = "@function.outer", desc = "Select outer function" },
            ["if"] = { query = "@function.inner", desc = "Select inner function" },
            ["ac"] = { query = "@class.outer", desc = "Select outer class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner class" },
            -- ["ip"] = { query = "@parameter.inner", desc = "Select inner parameter" },
            -- ["ap"] = { query = "@parameter.outer", desc = "Select outer parameter" },
            ["as"] = { query = "@statement.outer", desc = "Select outer statement" },
            ["is"] = { query = "@statement.inner", desc = "Select inner statement" },
            ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
            ["ab"] = { query = "@block.outer", desc = "Select outer block" },
            ["ib"] = { query = "@block.inner", desc = "Select inner block" },
            ["am"] = { query = "@call.outer", desc = "Select outer method call" },
            ["im"] = { query = "@call.inner", desc = "Select inner method call" },
            ["aa"] = { query = "@parameter.outer", desc = "Select outer argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner argument" },
            ["ak"] = { query = "@comment.outer", desc = "Select outer comment" },
            ["ik"] = { query = "@comment.inner", desc = "Select inner comment" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          --[[ selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@parameter.inner'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          }, ]]
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = false,
        },
      },
    }
  end
}
