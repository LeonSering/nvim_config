return
{
  "gbprod/yanky.nvim", -- better yanking and pasting
  priority = 10,       -- must be smaller than of telescope
  config = function()
    local utils = require("yanky.utils")
    local mapping = require("yanky.telescope.mapping")
    require("yanky").setup(
      {
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
          ignore_registers = { "_" },
          update_register_on_cycle = true,
        },
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            use_default_mappings = false, -- if default mappings should be used
            mappings = {
              default = mapping.put("p"),
              i = {
                ["<c-p>"] = mapping.put("p"),
                ["<c-CR>"] = mapping.put("P"),
                -- ["<c-k>"] = "move_selection_previous",
                ["<c-d>"] = mapping.delete(),
                ["<c-x>"] = mapping.delete(),
                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
              },
              n = {
                p = mapping.put("p"),
                P = mapping.put("P"),
                d = mapping.delete(),
                x = mapping.delete(),
                r = mapping.set_register(utils.get_default_register())
              },
            }
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 200,
        },
        preserve_cursor_position = {
          enabled = true,
        },
        textobj = {
          enabled = true,
        },
      })
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfterLinewise)", { desc = "Paste yanked text in next line" })
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBeforeLinewise)", { desc = "Paste yanked text in previous line" })
    vim.keymap.set("n", "<C-h>", "<Plug>(YankyPreviousEntry)", { desc = "Previous yanked entry" })
    vim.keymap.set("n", "<C-l>", "<Plug>(YankyNextEntry)", { desc = "Next yanked entry" })
    vim.keymap.set("i", "<C-v>", function()
      if vim.api.nvim_win_get_cursor(0)[2] == vim.api.nvim_get_current_line():len() then
        return "<C-o><Plug>(YankyGPutAfterCharwise)"
      else
        return "<C-o><Plug>(YankyGPutBeforeCharwise)"
      end
    end, { expr = true, desc = "Paste yanked text at cursor" })

    vim.api.nvim_set_hl(0, 'YankyYanked', { bg = 'Green', ctermbg = 'green', fg = 'Black', ctermfg = 'black' })
    vim.api.nvim_set_hl(0, 'YankyPut', { bg = 'DarkBlue', ctermbg = 17, fg = 'White', ctermfg = 'white' })

    require("telescope").load_extension("yank_history")
  end,

}
