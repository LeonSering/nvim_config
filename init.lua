----------------------------
----- LOAD PLUGINS ---------
----------------------------

-- LAZY - packet manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins:
require("lazy").setup(
{
  'numToStr/Comment.nvim',opts = {mappings = {basic = false, extra = false,}},lazy = false, -- for commentart
  'petertriho/nvim-scrollbar', -- scrollbar on right side
  'kevinhwang91/nvim-hlslens', -- better in page search with / and ?
  'chentoast/marks.nvim', -- better marks
  'github/copilot.vim', -- copilot autocompletion
  'folke/which-key.nvim', event = "VeryLazy", init = function() vim.o.timeout = true vim.o.timeoutlen = 300 end,
  'nvim-lua/plenary.nvim', -- required for telescope
  'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' },
  'nvim-treesitter/nvim-treesitter', -- syntax highlighting requires nvim 0.8
  -- 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  'nvim-tree/nvim-web-devicons', -- for spectre
  'nvim-pack/nvim-spectre', -- search and replace
  --[[ 
  "williamboman/mason.nvim", -- package manager for language servers
  'williamboman/mason-lspconfig.nvim', -- language server configurations
  'neovim/nvim-lspconfig', -- language server configurations
  'simrat39/rust-tools.nvim', -- rust tools 
  ]]
})

----------------------------
--- BASIC CONFIGURATION ----
----------------------------

-- set <leader> key to <space>
vim.g.mapleader = " "
vim.opt.autowriteall = true -- auto save
vim.opt.undofile = true -- save undo history between sessions
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.ctermcolors = true -- enable for colorschemes
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.clipboard:append("unnamed") -- yanks into "middle-mouse" clipboard

-- line numbers
vim.opt.number = true
vim.api.nvim_set_hl(0, 'LineNr', {ctermfg = 'grey', bold = false})

-- always show lines below coursor
vim.opt.scrolloff = 4

-- highlight the cursor line
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLineNr', {ctermfg = 'white', bold = true })
vim.opt.cursorlineopt = "number"

-- remove sign column background
vim.api.nvim_set_hl(0, 'SignColumn', {ctermbg = NONE}) 

-- color of matching parenthesis
vim.api.nvim_set_hl(0, 'MatchParen', {ctermfg = NONE, ctermbg = 'darkgrey' , cterm = NONE, bold = true }) 


----------------------------
------- KEY MAPPINGS -------
----------------------------
-- pressing Enter after { adds a } to the line below
vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O')

-- INSERT MODE --
-- movement
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

-- deletion
vim.keymap.set('i', '<C-s>', '<Bs>') -- delete character under cursor
vim.keymap.set('i', '<C-b>', '<C-o>db') -- delete previous word
-- default setting: <C-u> delete everthing on the left
vim.keymap.set('i', '<C-x>', '<Del>') -- delete single char on the right of cursor
vim.keymap.set('i', '<C-w>', '<C-o>dw') -- delete next word
vim.keymap.set('i', '<C-a>', '<C-o>d$') -- delete to end of line

-- comment
vim.keymap.set('i', '<C-/>', '<C-o>:CommentToggle<CR>') -- toggle comment

-- paste
vim.keymap.set('i', '<C-v>', '<C-r>+') -- paste

-- VISUAL MODE --
vim.keymap.set('v', '<C-c>', '"+y') -- copy
vim.keymap.set('v', '<C-x>', '"+d') -- copy


-- COMMAND LINE MODE --
-- movement
vim.keymap.set('c', '<C-h>', '<Left>')
vim.keymap.set('c', '<C-j>', '<Down>')
vim.keymap.set('c', '<C-k>', '<Up>')
vim.keymap.set('c', '<C-l>', '<Right>')

-- deletion
vim.keymap.set('c', '<C-s>', '<Bs>') -- delete character under cursor
vim.keymap.set('c', '<C-x>', '<Del>') -- delete single char on the right of cursor
-- default setting: <C-u> delete everthing on the left

-- DISABLE KEYS --
-- disable some unused keys
vim.keymap.set('n', '!', '<Nop>') -- disable ! in normal mode
vim.keymap.set('n', 'q:', '<Nop>') -- disable q: in normal mode
vim.keymap.set('n', 'q/', '<Nop>') -- disable q/ in normal mode
vim.keymap.set('n', 'q?', '<Nop>') -- disable q? in normal mode
vim.keymap.set('n', 'ZZ', '<Nop>') -- disable ZZ in normal mode
vim.keymap.set('n', 'ZQ', '<Nop>') -- disable ZQ in normal mode
vim.keymap.set('i', '<C-z>', '<Nop>') -- disable <C-z> in insert mode
vim.keymap.set('i', '<C-c>', '<Nop>') -- disable <C-c> in insert mode
vim.keymap.set('i', '<C-@>', '<Nop>') -- disable <C-@> in insert mode
vim.keymap.set('i', '<C-i>', '<Nop>') -- disable <C-i> in insert mode
vim.keymap.set('i', '<C-n>', '<Nop>') -- disable <C-n> in insert mode
vim.keymap.set('i', '<C-f>', '<Nop>') -- disable <C-f> in insert mode

-- disable keys for learning:
vim.keymap.set('i', '<BS>', '<Nop>') -- disable Backspace in insert mode (use <C-s> instead)
vim.keymap.set('i', '<Del>', '<Nop>') -- disable Backspace in insert mode (use <C-x> instead)
vim.keymap.set('i', '<Home>', '<Nop>') -- disable Home in insert mode (go to normal mode and use 0 instead)
vim.keymap.set('i', '<End>', '<Nop>') -- disable Home in insert mode (go to normal mode use $ instead)
vim.keymap.set('i', '<Left>', '<Nop>') -- disable Left in insert mode (use <C-h> instead)
vim.keymap.set('i', '<Down>', '<Nop>') -- disable Down in insert mode (use <C-j> instead)
vim.keymap.set('i', '<Up>', '<Nop>') -- disable Up in insert mode (use <C-k> instead)
vim.keymap.set('i', '<Right>', '<Nop>') -- disable Right in insert mode (use <C-l> instead)

vim.keymap.set('c', '<BS>', '<Nop>') -- disable Backspace in insert mode (use <C-s> instead)
vim.keymap.set('c', '<Del>', '<Nop>') -- disable Backspace in insert mode (use <C-x> instead)
vim.keymap.set('c', '<Left>', '<Nop>') -- disable Left in insert mode (use <C-h> instead)
vim.keymap.set('c', '<Down>', '<Nop>') -- disable Down in insert mode (use <C-j> instead)
vim.keymap.set('c', '<Up>', '<Nop>') -- disable Up in insert mode (use <C-k> instead)
vim.keymap.set('c', '<Right>', '<Nop>') -- disable Right in insert mode (use <C-l> instead)


----------------------------
------- PLUGIN SETUP -------
----------------------------

-------------
-- comment --
-------------

require('Comment').setup()
vim.keymap.set('n', '<C-k>', '<Plug>(comment_toggle_linewise_current)<up>')
vim.keymap.set('n', '<C-j>', '<Plug>(comment_toggle_linewise_current)<down>')
vim.keymap.set('x', '<C-k>', '<Plug>(comment_toggle_linewise_visual)<up>')
vim.keymap.set('x', '<C-j>', '<Plug>(comment_toggle_linewise_visual)<down>')
-- set Ctrl + / to toggle comment
vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)')
vim.keymap.set('i', '<C-_>', '<C-o><Plug>(comment_toggle_linewise_current)')
vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_blockwise_visual)')

-- disable auto comment on <CR>. <Esc>o can be used for new line with comment
vim.api.nvim_create_autocmd({"BufNewFile","BufRead"}, {
  pattern = '*',
  callback = function ()
    vim.opt.formatoptions:remove({ 'r' })
  end
})
-- set Shift+Enter to new line with comment
-- set Return+Shift to \E[13;2u in terminal profil to allow this combination
vim.keymap.set('i', '<S-CR>', '<Esc>o')


-------------
-- hlslens --
-------------

-- use scrollbar.handlers.search instead of hlslens to be compatible with scrollbar
require("scrollbar.handlers.search").setup({
    calm_down = true, -- disable the search highlight when the cursor moves
    nearest_only = true, -- only lens-window for the nearest match
})

local kopts = {noremap = true, silent = true}

-- keymapping when starting search
vim.keymap.set('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.keymap.set('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

-- highlighting
vim.api.nvim_set_hl(0, 'HlSearchNear', {ctermfg = 'green', ctermbg = 'black', bold = true })
vim.api.nvim_set_hl(0, 'IncSearch', {ctermfg = 'black', ctermbg = 'green' , bold = true }) -- nearest match
vim.api.nvim_set_hl(0, 'Search', {ctermfg = 'black', ctermbg = 'lightgrey' , bold = true }) -- other matches


---------------
-- scrollbar --
---------------
-- (must be below hlslens, otherwise hlslens configs are ignored)

require("scrollbar").setup({
    handle = {
        color_nr = 8, -- cterm -- dark grey
    },
    marks = {
        Cursor = {text = "◉",color_nr = 15},
        Search = {color_nr = 10}, -- green
        Error = {color_nr = 9}, -- red
        Warn = {color_nr = 11}, -- yellow
        Info = {color_nr = 14}, -- cyan
        Hint = {color_nr = 15}, -- white
        Misc = {color_nr = 15}, -- white
    },
    handlers = {
        search = true, -- Requires hlslens
    },
})


-----------
-- marks --
-----------

require('marks').setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", '"', "`", "^", "[", "]" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
}
vim.api.nvim_set_hl(0, 'MarkSignHl', {ctermbg = 'none', ctermfg = 'grey', bold = true})
vim.api.nvim_set_hl(0, 'MarkSignNumHl', {ctermbg = 'none', ctermfg = 'none'})


--------------------
-- GitHub Copilot --
--------------------

-- you must set Return+Ctrl to \E[13;5u in terminal profil to allow this combination
vim.keymap.set('i', '<C-CR>', 'copilot#Accept("")', {expr = true,replace_keycodes = false})
vim.keymap.set('i', '<C-p>', '<Plug>(copilot-accept-line)')
vim.keymap.set('i', '<C-o>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-Down>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<C-Up>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-Left>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-suggest)')
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<Tab>', '\t') -- disable tab to accept copilot suggestion


---------------
-- Telescope --
---------------

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fu', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {})
vim.keymap.set('n', '<leader>ft', builtin.tags, {})
vim.keymap.set('n', '<leader>fi', builtin.current_buffer_tags, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>f;', builtin.commands, {})
vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fz', builtin.builtin, {})
vim.keymap.set('n', '<leader>fzc', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>fzo', builtin.vim_options, {})
vim.keymap.set('n', '<leader>fzh', builtin.highlights, {})
vim.keymap.set('n', '<leader>fza', builtin.autocommands, {})

-- TODO lsp picker 
-- TODO git picker
-- vim.keymap.set('n', '<leader>fa', function() require('telescope.builtin').live_grep({cwd = '/home/leon/nvim_keymapping/'}) end)
-- TODO open nvim.md in sidepanel

require('telescope').setup {
  defaults = {
    initial_mode = "normal",
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-Down>"] = "cycle_history_next",
        ["<C-Up>"] = "cycle_history_prev",
        ["<C-h>"] = {"<Left>", type = "command"},
        ["<C-l>"] = {"<Right>", type = "command"},
        ["<C-s>"] = {"<Bs>", type = "command"},
        ["<C-b>"] = {"<C-o>db<Bs>", type = "command"},
        ["<C-u>"] = {"<C-o>d0", type = "command"},
        ["<C-x>"] = {"<Del>", type = "command"},
        ["<C-w>"] = {"<C-o>dw", type = "command"},
        ["<C-a>"] = {"<C-o>d$", type = "command"},
        ["<C-v>"] = "select_vertical",
      },
      n = {
        ["v"] = "select_vertical",
        ["<C-Down>"] = "cycle_history_next",
        ["<C-Up>"] = "cycle_history_prev",
      }
    },
  },
  pickers = {
    find_files = {
      initial_mode = "insert",
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.5,
        height = 0.8,
      },
    },
    oldfiles = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.5,
        height = 0.8,
      },
    },
    live_grep = {
      initial_mode = "insert",
    },
    current_buffer_fuzzy_find = {
      initial_mode = "insert",
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.5,
        height = 0.8,
      },
    },
    help_tags = {
      initial_mode = "insert",
      mappings = {
        i = {
          ["<CR>"] = "select_vertical",
        },
        n = {
          ["<CR>"] = "select_vertical",
        },
      },
    },
    tags = {
      initial_mode = "insert",
    },
    current_buffer_tags = {
      initial_mode = "insert",
    },
    commands = {
      initial_mode = "insert",
    },
    builtin = {
      initial_mode = "insert",
    },
    vim_options = {
      initial_mode = "insert",
    },
    highlights = {
      initial_mode = "insert",
    },
    autocommands = {
      initial_mode = "insert",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- require('telescope').load_extension('fzf')

vim.api.nvim_set_hl(0, 'TelescopeMatching', {ctermfg = 'darkyellow', bold = true}) -- highlight matching text

-------------
-- Spectre --
-------------

require('spectre').setup({
	highlight = {ui = "String", search = "DiffChange", replace = "DiffDelete"}
})

vim.keymap.set('n', '<leader>SR', function() require("spectre").open() end, {
    desc = "Spectre: Search and replace in working directory"
})
vim.keymap.set('n', '<leader>SW', function() require("spectre").open_visual({select_word=true}) end, {
    desc = "Spectre: Search current word in working directory"
})
vim.keymap.set('v', '<leader>SR', 'y<cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Spectre: Search selection in working directory"
})
vim.keymap.set('n', '<leader>sr', function() require("spectre").open({path = vim.fn.fnameescape(vim.fn.expand('%:p:.'))}) end, {
    desc = "Spectre: Search selection in current file (without search text)"
})
vim.keymap.set('n', '<leader>sw', function() require("spectre").open_file_search({select_word=true}) end, {
    desc = "Spectre: Search current word in current file"
})
vim.keymap.set('v', '<leader>sr', 'y<cmd>lua require("spectre").open_file_search()<CR>', {
    desc = "Spectre: Search selection in current file"
})




-- which-key
-- require("which-key").setup ()

--[[
require("mason").setup()
require("mason-lspconfig").setup()
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
]]
