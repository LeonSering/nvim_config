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
  { 'anuvyklack/windows.nvim', dependencies = { -- enlarge current window, equal all others
    'anuvyklack/middleclass',
  }},
  'numToStr/Comment.nvim', -- for commentary
  'petertriho/nvim-scrollbar', -- scrollbar on right side
  'kevinhwang91/nvim-hlslens', -- better in page search with / and ?
  'chentoast/marks.nvim', -- better marks
  { "kylechui/nvim-surround", event = "VeryLazy"}, -- surround text with brackets
  'github/copilot.vim', -- copilot autocompletion
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'}, -- syntax highlighting
  {'HiPhish/rainbow-delimiters.nvim'}, -- rainbow brackets
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
    'nvim-lualine/lualine.nvim', dependencies = {
      'nvim-tree/nvim-web-devicons',
  }},
  'lewis6991/gitsigns.nvim', -- show git changes in the sign column
  'f-person/git-blame.nvim', -- git blame on <leader>gb
  {'stevearc/aerial.nvim', dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  }},
  'smoka7/hop.nvim', -- jump to any word in the buffer
  'rust-lang/rust.vim', -- running RustFmt and other short cuts
  'nvim-tree/nvim-tree.lua', -- file explorer
  {'folke/which-key.nvim', event = "VeryLazy", init = function() vim.o.timeout = true vim.o.timeoutlen = 300 end},
  {'williamboman/mason.nvim', dependencies = {'neovim/nvim-lspconfig'}}, -- package manager for language servers
  'williamboman/mason-lspconfig.nvim', -- language server configurations
  {'j-hui/fidget.nvim', opts = {}}, -- shows loading process of lsp
  {'nvimdev/lspsaga.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'}},
   'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp', -- Completion framework
  'hrsh7th/cmp-nvim-lsp', -- LSP completion source
  'L3MON4D3/LuaSnip', -- Snippet engine for cmp

  -- Useful completion sources:
  'hrsh7th/cmp-nvim-lua', -- for editing this init.lua file
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lsp-document-symbol',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  { 'windwp/nvim-autopairs', config = true }, -- for automatically insert parenthesis when choosing function from completion
})

----------------------------
--- BASIC CONFIGURATION ----
----------------------------

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- active window width is >=130 all other windows are equally sized
vim.o.equalalways = false
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
vim.g.have_nerd_font = true
vim.opt.breakindent = true -- auto indent when breaking lines
vim.opt.scrolloff = 4 -- always show lines below coursor

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes" -- always show sign column

vim.opt.diffopt= "internal,filler,closeoff,hiddenoff" -- better diff
vim.opt.fillchars = "diff: " -- better diff
-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', nbsp = '␣' }


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-------------------------
------ COLORSCHEME ------
-------------------------

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
  vim.api.nvim_set_hl(0, 'CursorLineNr', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'CursorLine', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'Folded', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'SpecialKey', {bg = 'None', ctermbg = 'none'}) -- background color
  vim.api.nvim_set_hl(0, 'FoldColumn', {bg = 'None', ctermbg = 'none'}) -- background color

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
vim.api.nvim_set_hl(0, 'Pmenu', {ctermfg = 'lightgray', ctermbg = 'black', fg = 'LightGray', bg = 'Black', bold = false })
vim.api.nvim_set_hl(0, 'PmenuSel', {ctermfg = 'white', ctermbg = 'darkgray', fg = 'White', bg = 'DarkGray', bold = false })

-- color of matching parenthesis
vim.api.nvim_set_hl(0, 'MatchParen', {ctermbg = 'darkgray', bg = 'DarkGray', bold = true })

-- vimdiff
vim.api.nvim_set_hl(0, 'DiffAdd', {ctermbg = 22, bg = 'DarkGreen'})
vim.api.nvim_set_hl(0, 'DiffChange', {ctermbg = 17, bg = 'NavyBlue'})
vim.api.nvim_set_hl(0, 'DiffDelete', {ctermfg = 'gray', ctermbg = 'none', fg = 'Gray', bg = 'None'})
vim.api.nvim_set_hl(0, 'DiffText', {ctermbg = 52, bg = 'DarkRed'})


----------------------------
------- KEY MAPPINGS -------
----------------------------

-- INSERT MODE / COMMAND LINE MODE --

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
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- clear search highlight
vim.keymap.set('n', '<Cr>', 'ciw') -- change word under cursor
vim.keymap.set('n', '<Bs>', 'ch') -- change word under cursor
vim.keymap.set('n', '<leader><Cr>', 'ci(') -- change text inside parenthesis
vim.keymap.set('n', '<leader>(', 'ci(') -- change text inside parenthesis
vim.keymap.set('n', '<leader>)', 'ci)') -- change text inside parenthesis
vim.keymap.set('n', '<leader>[', 'ci[') -- change text inside brackets
vim.keymap.set('n', '<leader>]', 'ci]') -- change text inside brackets
vim.keymap.set('n', '<leader>{', 'ci{') -- change text inside curly brackets
vim.keymap.set('n', '<leader>{', 'ci}') -- change text inside curly brackets
vim.keymap.set('n', '<leader><', 'ci<', {desc = "ci<"}) -- change text inside tag
vim.keymap.set('n', '<leader>>', 'ci>', {desc = "ci>"}) -- change text inside tag
vim.keymap.set('n', '<leader>"', 'ci"') -- change text inside double quotes
vim.keymap.set('n', "<leader>'", "ci'") -- change text inside single quotes
vim.keymap.set('n', '<leader>`', 'ci`') -- change text inside double quotes

vim.keymap.set('n', '<leader>/', '<Cmd>vsplit ~/.config/nvim/keymappings.md<CR>', {desc = "Open keymappings.md"})
vim.keymap.set('n', '<leader>?', '<Cmd>vsplit ~/.config/nvim/keymappings.md<CR>', {desc = "Open keymappings.md"})
vim.keymap.set('n', '<leader>\\', '<Cmd>vsplit ~/.config/nvim/init.lua<CR>', {desc = "Open init.lua"})
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- move down half a page and center cursor
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- move down half a page and center cursor
--[[ vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(args)
    vim.keymap.set('n', '<leader>p', ':%!jq . %<CR>') -- format json with jq
  end
}) ]]

-- DISABLE KEYS --
-- disable some unused keys
vim.keymap.set('n', '<C-w>', '<Nop>') -- disable <C-w> in normal mode
vim.keymap.set('n', '!', '<Nop>') -- disable ! in normal mode
vim.keymap.set({'n', 'v'}, 'q:', '<Nop>') -- disable q: in normal and visual mode
vim.keymap.set('n', 'q/', '<Nop>') -- disable q/ in normal mode
vim.keymap.set('n', 'q?', '<Nop>') -- disable q? in normal mode
vim.keymap.set('n', 'ZZ', '<Nop>') -- disable ZZ in normal mode
vim.keymap.set('n', 'ZQ', '<Nop>') -- disable ZQ in normal mode
vim.keymap.set('n', 'gf', '<Nop>') -- disable gf in normal mode
vim.keymap.set('n', 'gx', '<Nop>') -- disable gf in normal mode
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
vim.keymap.set('c', '<Right>', '<Nop>') -- disable Right in insert mode (use <C-l> instead)


----------------------------
------- PLUGIN SETUP -------
----------------------------

-------------
-- Windows --
-------------

require('windows').setup({
  autowidth = {
    winwidth = 50, -- width of current window &textwidth + value
  }
})
vim.keymap.set({'n', 'i', 'v'}, '<A-a>', '<cmd>wincmd W<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-h>', '<cmd>wincmd W<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-d>', '<cmd>wincmd w<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-l>', '<cmd>wincmd w<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-e>', '<cmd>wincmd v<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-z>', '<cmd>q<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-x>', '<cmd>wincmd R<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-c>', '<cmd>wincmd r<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-w>', '<cmd>WindowsMaximize<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-s>', '<cmd>wincmd =<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<A-q>', '<cmd>wincmd o<CR>')

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
vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], {silent = true, desc="Search word under cursor forward"})
vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], {silent = true, desc="Search word under cursor backward"})
vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], {silent= true, desc="Search word under cursor forward"})
vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], {silent = true, desc="Search word under cursor backward"})

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
  builtin_marks = {"<", ">", "^", "[", "]" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
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
  mappings = {
    preview = "", -- disable preview
  },
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
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Telescope: Find files"})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {desc = "Telescope: Open old files"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Telescope: Live grep"})
vim.keymap.set('n', '<leader>fu', builtin.current_buffer_fuzzy_find, {desc = "Telescope: Fuzzy find in current buffer"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "Telescope: Buffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Telescope: Help tags"})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {desc = "Telescope: Command history"})
vim.keymap.set('n', '<leader>f/', builtin.search_history, {desc = "Telescope: Search history"})
vim.keymap.set('n', '<leader>ft', builtin.tags, {desc = "Telescope: Tags"})
vim.keymap.set('n', '<leader>fi', builtin.current_buffer_tags, {desc = "Telescope: Tags in current buffer"})
vim.keymap.set('n', '<leader>fm', builtin.marks, {desc = "Telescope: Marks"})
vim.keymap.set('n', '<leader>fr', builtin.registers, {desc = "Telescope: Registers"})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {desc = "Telescope: Jump list"})
vim.keymap.set('n', '<leader>fq', builtin.quickfix, {desc = "Telescope: Quickfix"})
vim.keymap.set('n', '<leader>f:', builtin.commands, {desc = "Telescope: Commands"})
vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, {desc = "Telescope: Spell suggest"})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {desc = "Telescope: Keymaps"})
vim.keymap.set('n', '<leader>fz', builtin.builtin, {desc = "Telescope: Builtin"})
vim.keymap.set('n', '<leader>fzc', builtin.colorscheme, {desc = "Telescope: Colorscheme"})
vim.keymap.set('n', '<leader>fzo', builtin.vim_options, {desc = "Telescope: Vim options"})
vim.keymap.set('n', '<leader>fzh', builtin.highlights, {desc = "Telescope: Highlights"})
vim.keymap.set('n', '<leader>fza', builtin.autocommands, {desc = "Telescope: Autocommands"})

vim.keymap.set('n', '<leader>fe', builtin.diagnostics, {desc = "Telescope: Diagnostics"})
vim.keymap.set('n', '<leader>fv', builtin.lsp_document_symbols, {desc = "Telescope: LSP document symbols"})
vim.keymap.set('n', '<leader>fV', builtin.lsp_workspace_symbols, {desc = "Telescope: LSP workspace symbols"})
vim.keymap.set('n', '<leader>FV', builtin.lsp_workspace_symbols, {desc = "Telescope: LSP workspace symbols"})

vim.keymap.set('n', '<leader>gd', builtin.git_bcommits, {desc = "Telescope: Git commits (buffer)"})
-- TODO git picker

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
    lsp_workspace_symbols = {
      initial_mode = "insert",
      fname_width = 0.4,
    },
    git_bcommits = {
      mappings = {
        i = {
          ["<CR>"] = "select_vertical",
        },
        n = {
          ["<CR>"] = "select_vertical",
        },
      },
    }

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
	highlight = {ui = "String", search = "DiffDelete", replace = "DiffAdd"},
  mapping = {
    ['run_current_replace'] = {
      map = "<leader>r",
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


-------------
-- GitSign --
-------------

require('gitsigns').setup {
  signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
  sign_priority = 1000,
  attach_to_untracked = true,
    on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end
    map('n', '<leader>gs', '<cmd>Gitsigns toggle_signs<CR>')
    map('n', '<leader>gw', '<cmd>Gitsigns toggle_word_diff<CR>')
  end
}
vim.api.nvim_set_hl(0, 'GitSignsAdd', {ctermfg = 'darkgreen', fg = 'DarkGreen', ctermbg = 'none', bg = 'None', bold = true})
vim.api.nvim_set_hl(0, 'GitSignsChange', {ctermfg = 'darkblue', fg = 'DarkBlue', ctermbg = 'none', bg = 'None', bold = true})
vim.api.nvim_set_hl(0, 'GitSignsDelete', {ctermfg = 'magenta', fg = 'DarkRed', ctermbg = 'none', bg = 'None', bold = true})


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
require("telescope").load_extension("aerial")
vim.keymap.set('n', '<leader>fa', require("telescope").extensions.aerial.aerial, {desc = "Telescope: Aerial"})

----------
-- Rust --
----------

-- run RustFmt on the current file only
-- cargo test and scroll to the bottom of the vim-terminal
vim.keymap.set('n', '<leader>ct', ':RustTest<CR>G', {desc = "Cargo: Run current test"}) -- run test under cursor
vim.keymap.set('n', '<leader>cT', ':RustTest!<CR>G', {desc = "Cargo: Run all tests"}) -- run all tests
vim.keymap.set('n', '<leader>CT', ':RustTest!<CR>G', {desc = {"Cargo: Run all tests"}}) -- run all tests

-- cargo run and scroll to the bottom of the vim-terminal
vim.keymap.set('n', '<leader>cr', ':Crun<CR>G', {desc = "Cargo: Run"})
-- cargo build and scroll to the bottom of the vim-terminal
vim.keymap.set('n', '<leader>cb', ':Cbuild<CR>G', {desc = "Cargo: Build"})
vim.g.rustfmt_autosave = 1 -- automatic run :RustFmt on save

---------------
-- Nvim-tree --
---------------
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
local WIDTH_RATIO = 0.5  -- You can change this too
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
vim.keymap.set({'i', 'v'}, '<C-n>', '<Esc><Cmd>NvimTreeFindFileToggle<CR>')
vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', {ctermbg = 'darkgray', bg = 'DarkGray', bold = true })
vim.api.nvim_set_hl(0, 'SpellCap', {ctermbg = 'None', bg = 'None', bold = true }) -- Readme.md and toml files
vim.api.nvim_set_hl(0, 'SpellRare', {ctermbg = 'white', ctermfg = 'black', bg = 'White', fg = 'Black', bold = true }) -- Copies files

---------
-- hop --
---------

require("hop").setup({
  multi_windows = true,
})

-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', ';', function() -- TODO choose different key
  hop.hint_words({multi_windows = true})
end, {remap=true})
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1()
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({multi_windows = true})
end, {remap=true})

---------------
-- which-key --
---------------

require("which-key").setup ()

-----------
-- mason --
-----------

require("mason").setup()
require("mason-lspconfig").setup( {
  automatic_installation = true,
})
-- :MasonInstall codelldb
vim.cmd("MasonUpdate") -- update language servers on startup



----------------
-- Treesitter --
----------------

-- Treesitter Plugin Setup
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml", "json", "yaml", "python"},
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true },
}

------------------------
-- rainbow-delimiters --
------------------------
-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
    },
}

---------------
-- LSPConfig --
---------------


-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}

require'lspconfig'.jsonls.setup{}

require'lspconfig'.pyright.setup{}

require'lspconfig'.lua_ls.setup {}

require'lspconfig'.taplo.setup{} -- TOML

require'lspconfig'.yamlls.setup{}

-- Set up diagnostics.
vim.diagnostic.config({
    virtual_text = false, -- disable inline diagnostics
    signs = true,
})

-- set hotkey for formatting
vim.keymap.set('n', '<leader>p', function() vim.lsp.buf.format { async = true } end, {desc = "LSP: Format"})

-- DISPLAY DIAGNOSTICS IN THE COMMAND BAR
-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }
-- The timer used for displaying a diagnostic in the commandline.
local echo_timer = nil
-- The timer after which to display a diagnostic in the commandline.
local echo_timeout = 250
-- The highlight group to use for warning messages.
local warning_hlgroup = 'WarningMsg'
-- The highlight group to use for error messages.
local error_hlgroup = 'ErrorMsg'
-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
local short_line_limit = 20
  -- Shows the current line's diagnostics in a floating window.
function show_line_diagnostics()
	vim.lsp.diagnostic.show_line_diagnostics({ severity_limit = 'Warning' }, vim.fn.bufnr(''))
end
-- Prints the first diagnostic for the current line.
local echo_diagnostic = function()
	if echo_timer then
		echo_timer:stop()
	end
	echo_timer = vim.defer_fn(function()
		local line = vim.fn.line('.') - 1
		local bufnr = vim.api.nvim_win_get_buf(0)
		if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
			return
		end
		local diags = vim.lsp.diagnostic.get_line_diagnostics()
		if #diags == 0 then
			-- If we previously echo'd a message, clear it out by echoing an empty
			-- message.
			if last_echo[1] then
				last_echo = { false, -1, -1 }
				vim.api.nvim_command('echo ""')
			end
			return
		end
		last_echo = { true, bufnr, line }
		local diag = diags[1]
		local width = vim.api.nvim_get_option('columns') - 15
		local lines = vim.split(diag.message, '\n')
		local message = lines[1]
		local trimmed = false
		if #lines > 1 and #message <= short_line_limit then
			message = message .. ' ' .. lines[2]
		end
		if width > 0 and #message >= width then
			message = message:sub(1, width) .. '...'
		end
		local kind = 'Warning'
		local hlgroup = warning_hlgroup
		if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
			kind = 'Error'
			hlgroup = error_hlgroup
		end
		local chunks = {
			{ kind , hlgroup},
			{ ' ' .. message },
		}
		vim.api.nvim_echo(chunks, false, {})
	end, echo_timeout)
end
vim.api.nvim_create_autocmd({"CursorMoved"}, {
  pattern = "*",
  callback = function()
    echo_diagnostic()
  end,
})


-------------
-- LSPSaga --
-------------

require('lspsaga').setup({
  symbol_in_winbar = {
    enable = false,
  },
  code_action = {
    keys = {
      quit = {'<Esc>', 'q'},
      exec = '<Cr>',
    },
  },
  definition = {
      keys = {
          edit = '<Cr>',
          vsplit = 'v',
          quit = '<Esc>',
          close = 'q',
      }
  },
  finder = {
    default = 'def+tyd+ref+imp',
      keys = {
          edit = '<Cr>',
          vsplit = 'v',
          quit = '<Esc>',
          close = 'q',
      }
  },
  lightbulb = {
    virtual_text = false,
  },
  rename = {
    in_select = false,
    auto_save = true,
    keys = {
      quit = {'<Esc><Esc>', 'q'},
      exec = '<Cr>',
      select = 'x',
    },
  },
  beacon = {
    frequency = 15,
  },
  diagnostic = {
    extend_relatedInformation = true,
    keys = {
      quit = {'<Esc>', 'q'},
    }
  },
})

vim.keymap.set('n', '<leader>q', '<cmd>Lspsaga code_action<CR>', {desc = "LSP: Code action"})
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {desc = "LSP: Hover"})
vim.keymap.set('n', '<leader>d', '<cmd>Lspsaga peek_definition<CR>', {desc = "LSP: Peek definition"})
vim.keymap.set('n', '<leader>t', '<cmd>Lspsaga peek_type_definition<CR>', {desc = "LSP: Peek type definition"})
vim.keymap.set('n', '<leader>u', '<cmd>Lspsaga finder ref<CR>', {desc = "LSP: List references"})
vim.keymap.set('n', '<leader>i', '<cmd>Lspsaga finder<CR>', {desc = "LSP: List def, type def, ref, impl"})
vim.keymap.set('n', '<leader>r', '<cmd>Lspsaga rename<CR>', {desc = "LSP: Rename"})
vim.keymap.set('n', '<leader>e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {desc = "LSP: Previous diagnostic"})
vim.keymap.set('n', '<leader>E', '<cmd>Lspsaga diagnostic_jump_next<CR>', {desc = "LSP: Next diagnostic"})

vim.api.nvim_set_hl(0, 'CodeActionNumber', {bg = 'None', ctermbg = 'none'})


--------------
-- nvim-cmp --
--------------
--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
require("luasnip.loaders.from_vscode").lazy_load()
-- vim.opt.completeopt = {'menuone', 'noinsert'}
vim.opt.completeopt = {'menu', 'menuone', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
-- vim.api.nvim_set_option('updatetime', 300)
-- Completion Plugin Setup
local cmp = require('cmp')
cmp.setup({
  completion = {
    autocomplete = false, -- no automatic popup
  },
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
   ['<C-j>'] = function(fallback)
     if cmp.visible() then
       if cmp.core.view.custom_entries_view:is_direction_top_down() then
         cmp.select_next_item({behavior=cmp.SelectBehavior.Select})
       else
         cmp.select_prev_item({behavior=cmp.SelectBehavior.Select})
       end
     else
       fallback()
     end
   end,
   ['<C-k>'] = function(fallback)
     if cmp.visible() then
       if cmp.core.view.custom_entries_view:is_direction_top_down() then
         cmp.select_prev_item({behavior=cmp.SelectBehavior.Select})
       else
         cmp.select_next_item({behavior=cmp.SelectBehavior.Select})
       end
     else
       fallback()
     end
   end,
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Select}),
    ['<Tab>'] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Select}),
    --[[ ['<Tab>'] = function()
      if cmp.visible() then
        cmp.select_next_item({behavior=cmp.SelectBehavior.Select})
      else
        cmp.complete()
      end
    end, ]]
    ['<C-S-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-S-k>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = function()
      if cmp.visible() then
        cmp.confirm()
      else
        cmp.complete()
      end
    end,
    ['<Esc>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp'},      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lsp_document_symbol' },          -- document symbols
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'luasnip', keyword_length = 2 },       -- nvim-cmp source for vim-vsnip
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  view = {
    entries = { name = 'custom', selection_order = 'bottom_up' }
  },
})
vim.opt.pumheight = 10  -- limit the number of suggestions


--------------------
-- nvim-autopairs --
--------------------

require('nvim-autopairs').setup({
})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-------------------
-- nvim-surround --
-------------------

require('nvim-surround').setup({
  surrounds = {
      ["("] = false,
      ["{"] = false,
      ["["] = false,
      ["<"] = false,
  },
  aliases = {
      ["("] = ")",
      ["{"] = "}",
      ["["] = "]",
      ["<"] = ">",
      ["b"] = {">", ")", "]", "}"}
  },
})
vim.g.surround_insert_space = 0 -- no space when inserting brackets
