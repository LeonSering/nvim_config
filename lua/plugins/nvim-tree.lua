return {
  'nvim-tree/nvim-tree.lua', -- file explorer
  config = function()
    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- custom mappings
      -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 'r', api.fs.rename_full, opts('Rename: Full Path'))
      vim.keymap.set('n', '<Esc>', api.tree.close, opts('Close'))
      vim.keymap.set('n', 'C', api.tree.collapse_all, opts('Collapse All'))
      vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))
      vim.keymap.set('n', 'f', function()
        api.tree.expand_all()
        api.live_filter.start()
      end, opts('Live Filter: Start'))
      vim.keymap.set('n', 'F', function()
        api.tree.collapse_all()
        api.live_filter.clear()
      end, opts('Live Filter: Clear'))
    end
    local HEIGHT_RATIO = 0.8 -- You can change this
    local WIDTH_RATIO = 0.5 -- You can change this too
    require("nvim-tree").setup({
      disable_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      on_attach = my_on_attach,
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = { enable = false },
        },
      },
      diagnostics = {
        enable = true,
      },
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      live_filter = {
        always_show_folders = false,
      },
      filters = {
        dotfiles = true,
        exclude = { ".gitignore" }
      },
    })

    -- close if nvim-tree is the last buffer
    vim.api.nvim_create_autocmd('BufEnter', {
      command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
      nested = true,
    })

    vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeFindFileToggle<CR>')
    vim.keymap.set({ 'i', 'v' }, '<C-n>', '<Esc><Cmd>NvimTreeFindFileToggle<CR>')
    vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { ctermbg = 'darkgray', bg = 'DarkGray', bold = true })
    vim.api.nvim_set_hl(0, 'SpellCap', { ctermbg = 'None', bg = 'None', bold = true })                                 -- Readme.md and toml files
    vim.api.nvim_set_hl(0, 'SpellRare', { ctermbg = 'white', ctermfg = 'black', bg = 'White', fg = 'Black', bold = true }) -- Copies files
  end
}
