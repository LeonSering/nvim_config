return {
  'nvimdev/lspsaga.nvim', -- LSP UI, code actions, preview for definiton, type definition, references, implementation, rename, diagnostic, etc. also: top status line
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },

  config = function(_, opts)
    require('lspsaga').setup {
      symbol_in_winbar = {
        folder_level = 0,
      },
      code_action = {
        keys = {
          quit = { '<Esc>', 'q' },
          exec = '<Cr>',
        },
      },
      definition = {
        keys = {
          edit = '<Cr>',
          vsplit = 'v',
          tabe = 't',
          quit = '<Esc>',
          close = 'q',
        }
      },
      finder = {
        methods = {
          ['tyd'] = 'textDocument/typeDefinition',
        },
        default = 'def+tyd+ref+imp+inc',
        keys = {
          edit = '<Cr>',
          vsplit = 'v',
          tabe = 't',
          quit = { '<Esc>', 'q' },
        },
      },
      lightbulb = {
        virtual_text = false,
      },
      --[[ rename = {
        in_select = false,
        auto_save = true,
        keys = {
          quit = { '<Esc><Esc>', '<C-c>' },
          exec = '<Cr>',
          select = 'x',
        },
      }, ]]
      beacon = {
        frequency = 15,
      },
      diagnostic = {
        -- extend_relatedInformation = true,
        keys = {
          quit = { '<Esc>', 'q', '<C-c>' },
        }
      },
    }
    vim.keymap.set('n', '<leader>a', '<cmd>Lspsaga code_action<CR>', { desc = "LSP: Code action" })
    vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga peek_definition<CR>', { desc = "LSP: Peek definition" })
    vim.keymap.set('n', '<leader>t', '<cmd>Lspsaga finder tyd<CR>', { desc = "LSP: List type definitions" })
    vim.keymap.set('n', '<leader>u', '<cmd>Lspsaga finder<CR>', { desc = "LSP: List references" })
    -- vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>A', { desc = "LSP: Rename" })
    vim.keymap.set('n', '<leader>E', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = "LSP: Previous diagnostic" })
    vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = "LSP: Next diagnostic" })
    vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = "LSP: Previous diagnostic" })
    vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = "LSP: Next diagnostic" })

    vim.api.nvim_set_hl(0, 'CodeActionNumber', { bg = 'None', ctermbg = 'none' })
  end
}
