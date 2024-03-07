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
require("lazy").setup({
  'numToStr/Comment.nvim', -- for commentary
  'petertriho/nvim-scrollbar', -- scrollbar on right side
  'kevinhwang91/nvim-hlslens', -- better in page search with / and ?
  'chentoast/marks.nvim', -- better marks
  'github/copilot.vim', -- copilot autocompletion
  {'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { -- fuzzy finder
    'nvim-lua/plenary.nvim', 
    'nvim-treesitter/nvim-treesitter', -- for syntax highlighting
    'nvim-tree/nvim-web-devicons', -- for icons
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}, -- fzf backend, 
    -- if fzf not found: Do :Lazy -> Enter on telescope-fzf-native.nvim -> gb to build
  }},
  {'nvim-pack/nvim-spectre', dependencies = { -- search and replace
    'nvim-lua/plenary.nvim', 
    'nvim-tree/nvim-web-devicons', -- for icons
  }},
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  'f-person/git-blame.nvim', -- git blame on <leader>gb
  {'stevearc/aerial.nvim', dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  }},
  'rust-lang/rust.vim' -- running RustFmt and other short cuts
  -- {'folke/which-key.nvim', event = "VeryLazy", init = function() vim.o.timeout = true vim.o.timeoutlen = 300 end},
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

-- active window width is >=130 all other windows are equally sized
vim.opt.winwidth = 130
vim.cmd([[
  augroup AutoSwitchWindows
    autocmd!
    autocmd WinEnter * wincmd =
  augroup END
]])

vim.g.mapleader = " " -- set <leader> key to <space>
vim.opt.autowriteall = true -- auto save
vim.opt.hidden = false -- allow switching between buffers without saving
vim.opt.undofile = true -- save undo history between sessions
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.clipboard:append("unnamed") -- yanks into "middle-mouse" clipboard

vim.opt.scrolloff = 4 -- always show lines below coursor


-------------------------
------ COLORSCHEME ------
-------------------------

-- vim.opt.termguicolors = true -- enable for colorschemes
-- vim.cmd("syntax on")
-- vim.cmd("colorscheme torte")

local transparent_background = function()
  vim.api.nvim_set_hl(0, 'Normal', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'NonText', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'NormalNC', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'NormalSB', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'SignColumn', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'VertSplit', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'LineNr', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'CursorLineNr', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'CursorLine', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'Folded', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'SpecialKey', {bg = 'None', ctermbg = 'none'}) -- background color
end

transparent_background()
vim.api.nvim_create_autocmd({"ColorScheme"}, {
  pattern = "*",
  callback = function()
    transparent_background()
  end
})

-- line numbers
vim.opt.number = true
vim.api.nvim_set_hl(0, 'LineNr', {ctermfg = 'gray', fg = 'Gray', bold = false})


-- highlight the cursor line
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLineNr', {ctermfg = 'white', fg = 'white', bold = true })
vim.opt.cursorlineopt = "number"

-- highlight pmenu
vim.api.nvim_set_hl(0, 'Pmenu', {ctermfg = 'white', ctermbg = 'black', fg = 'White', bg = 'Black', bold = false })
-- vim.api.nvim_set_hl(0, 'Pmenu', {ctermfg = 'white', ctermbg = 'darkgrey', fg = 'White', bg = 'DarkGray', bold = false })

-- color of matching parenthesis
vim.api.nvim_set_hl(0, 'MatchParen', {ctermbg = 'darkgray', bg = 'DarkGray', bold = true }) 


----------------------------
------- KEY MAPPINGS -------
----------------------------


-- INSERT MODE / COMMAND LINE MODE --

vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O') -- pressing Enter after { adds a } to the line below

-- movement
vim.keymap.set({'i', 'c'}, '<C-h>', '<Left>')
vim.keymap.set({'i', 'c'}, '<C-j>', '<Down>')
vim.keymap.set({'i', 'c'}, '<C-k>', '<Up>')
vim.keymap.set({'i', 'c'}, '<C-l>', '<Right>')

-- deletion
vim.keymap.set({'i', 'c'}, '<C-s>', '<Bs>') -- delete character under cursor
vim.keymap.set('i', '<C-b>', 
function()
  if vim.api.nvim_win_get_cursor(0)[2] == vim.api.nvim_get_current_line():len() then
    return "<C-o>vbd"
  else
    return "<C-o>db"
  end
end, {expr = true}) -- delete previous word
-- default setting: <C-u> delete everthing on the left
vim.keymap.set({'i', 'c'}, '<C-x>', '<Del>') -- delete single char on the right of cursor
vim.keymap.set('i', '<C-w>', '<C-o>dw') -- delete next word
vim.keymap.set('i', '<C-a>', '<C-o>d$') -- delete to end of line

-- comment
vim.keymap.set('i', '<C-/>', '<C-o>:CommentToggle<CR>') -- toggle comment

-- paste
vim.keymap.set({'i', 'c'}, '<C-v>', '<C-r>+') -- paste


-- VISUAL MODE --
vim.keymap.set('v', '<C-c>', '"+y') -- copy
vim.keymap.set('v', '<C-x>', '"+d') -- cut 
vim.keymap.set('v', 'y', 'ygv<esc>') -- keep cursor at current position after yank


-- NORMAL MODE --
vim.keymap.set('n', '<Cr>', 'ciw') -- change word under cursor
vim.keymap.set('n', '<Bs>', 'ch') -- change word under cursor
vim.keymap.set('n', '<leader><Cr>', 'ci(') -- change text inside parenthesis
vim.keymap.set('n', '<leader>(', 'ci(') -- change text inside parenthesis
vim.keymap.set('n', '<leader>)', 'ci)') -- change text inside parenthesis
vim.keymap.set('n', '<leader>[', 'ci[') -- change text inside brackets
vim.keymap.set('n', '<leader>]', 'ci]') -- change text inside brackets
vim.keymap.set('n', '<leader>{', 'ci{') -- change text inside curly brackets
vim.keymap.set('n', '<leader>{', 'ci}') -- change text inside curly brackets
vim.keymap.set('n', '<leader><', 'ci<') -- change text inside tag
vim.keymap.set('n', '<leader>>', 'ci>') -- change text inside tag
vim.keymap.set('n', '<leader>"', 'ci"') -- change text inside double quotes
vim.keymap.set('n', "<leader>'", "ci'") -- change text inside single quotes
vim.keymap.set('n', '<leader>`', 'ci`') -- change text inside double quotes

vim.keymap.set('n', '<leader>/', '<Cmd>vsplit ~/.config/nvim/keymappings.md<CR>') -- open keymappings.md in sidepanel
vim.keymap.set('n', '<leader>\\', '<Cmd>vsplit ~/.config/nvim/init.lua<CR>') -- open init.lua in sidepanel
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- move down half a page and center cursor
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- move down half a page and center cursor
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(args)
    vim.keymap.set('n', '<leader>p', ':%!jq . %<CR>') -- format json with jq
  end
})

-- DISABLE KEYS --
-- disable some unused keys
vim.keymap.set('n', '!', '<Nop>') -- disable ! in normal mode
vim.keymap.set({'n', 'v'}, 'q:', '<Nop>') -- disable q: in normal and visual mode
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

require('Comment').setup({
  mappings = {
    basic = false,
    extra = false,
  },
})
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
vim.api.nvim_set_hl(0, 'HlSearchNear', {ctermfg = 'green', ctermbg = 'black', fg = 'LightGreen', bg = 'Black', bold = true })
vim.api.nvim_set_hl(0, 'IncSearch', {ctermfg = 'black', ctermbg = 'green', fg = 'Black', bg = 'LightGreen', bold = true }) -- nearest match
vim.api.nvim_set_hl(0, 'Search', {ctermfg = 'black', ctermbg = 'lightgrey', fg = 'Black', bg = 'LightGray', bold = true }) -- other matches


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
        Search = {color_nr = 'green', color = 'Green'},
        Error = {color_nr = 'red', color = 'Red'},
        Warn = {color_nr = 'yellow', color = 'Yellow'},
        Info = {color_nr = 'cyan', color = 'Cyan'},
        Hint = {color_nr = 'white', color = 'White'},
        Misc = {color_nr = 'white', color = 'White'},
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
vim.api.nvim_set_hl(0, 'MarkSignHl', {ctermbg = 'none', ctermfg = 'gray', bg = 'None', fg = 'Gray', bold = true})
vim.api.nvim_set_hl(0, 'MarkSignNumHl', {ctermbg = 'none', ctermfg = 'none' , bg = 'None', fg = 'None'})


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
vim.keymap.set('n', '\\', builtin.resume, {})
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
      no_ignore = true,
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
    keymaps = {
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
require("telescope").load_extension("fzf")

vim.api.nvim_set_hl(0, 'TelescopeMatching', {ctermfg = 'darkyellow', fg = 'Yellow', bold = true}) -- highlight matching text

-------------
-- Spectre --
-------------

require('spectre').setup({
	highlight = {ui = "String", search = "DiffChange", replace = "DiffDelete"},
  mapping = {
    ['run_current_replace'] = {
      map = "<leader>r",
    },
    ['toggle_live_update']={
      desc = "toggle live update"
    },
    ['send_to_qf'] = {
      desc = "all items to quickfix"
    },
  }
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


-------------
-- Lualine --
-------------

require('lualine').setup {
  -- options = {theme = 'papercolor_dark'},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {'filename', path = 1, color = {fg = 'lightgrey'}},
    },
    lualine_x = {
      {function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return space ~= 0 and "TW:"..space or ""
        end, color = {fg = 'red'}}, 
      'encoding', 
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_c = {
      {'filename', path = 1, color = {fg = 'lightgrey'}},
    },
    lualine_x = {},
  },
}

--------------
-- GitBlame --
--------------

require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
    message_template = '* <sha> <summary> • <author> • <date>',
    highlight_group = "Question",
    delay = 0,
}
vim.api.nvim_set_keymap('n', '<Leader>gb', '<Cmd>GitBlameToggle<CR>', kopts)


------------
-- Aerial --
------------

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  layout = {placement = "edge"},
  close_automatic_events = {"unfocus", "switch_buffer"},
  autojump = true,
  close_on_select = true,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set({"n", "v"}, "<C-a>", "<cmd>AerialToggle<CR>")
vim.keymap.set("i", "<C-a>", "<Esc><cmd>AerialToggle<CR>")
-- TODO
-- vim.keymap.set('n', '<leader>a', require("telescope").extensions.aerial.aerial(), {})

----------
-- Rust -- 
----------

-- run RustFmt on the current file only
-- cargo test and scroll to the bottom of the vim-terminal
vim.keymap.set('n', '<space>t', ':RustTest<CR>G') -- run test under cursor
vim.keymap.set('n', '<space>T', ':RustTest!<CR>G') -- run all tests

-- cargo run and scroll to the bottom of the vim-terminal
vim.keymap.set('n', '<space>rr', ':Crun<CR>G')
-- cargo build and scroll to the bottom of the vim-terminal
vim.keymap.set('n', '<space>rb', ':Cbuild<CR>G')

-- RustFmt
vim.keymap.set('n', '<space>p', ':RustFmt<CR>')

vim.g.rustfmt_autosave = 1 -- automatic run :RustFmt on save


---------------
-- which-key --
---------------

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

