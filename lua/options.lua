----------------------------
--- BASIC CONFIGURATION ----
----------------------------

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- active window width is >=130 all other windows are equally sized
vim.o.equalalways = false
vim.g.mapleader = " "       -- set <leader> key to <space>
vim.opt.autowriteall = true -- auto save
vim.opt.hidden = false      -- allow switching between buffers without saving
vim.opt.undofile = true     -- save undo history between sessions
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.clipboard:append("unnamed") -- yanks into "middle-mouse" clipboard
vim.g.have_nerd_font = true
vim.opt.breakindent = true          -- auto indent when breaking lines
vim.opt.scrolloff = 4               -- always show lines below coursor

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"                             -- always show sign column

vim.opt.diffopt = "internal,filler,closeoff,hiddenoff" -- better diff
vim.opt.fillchars = "diff: "                           -- better diff
-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', nbsp = '␣' }


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-------------------------
-- Auto close brackets --
-------------------------

-- only close brackets when '{' or '(' is the last character and <CR> is pressed

local waiting_for_brace = false

-- set waiting_for_brace to true when '{' or '(' is pressed
vim.keymap.set('i', '{', function()
  waiting_for_brace = true
  return "{"
end, { expr = true })

vim.keymap.set('i', '(', function()
  waiting_for_brace = true
  return "("
end, { expr = true })

vim.keymap.set('i', '[', function()
  waiting_for_brace = true
  return "["
end, { expr = true })

vim.keymap.set('i', '*', function()
  waiting_for_brace = true
  return '*'
end, { expr = true })

-- close brackets when <CR> is pressed but only if the cursor is at the end of the line and '(' or '{' is the last character
vim.keymap.set('i', '<CR>', function()
  if waiting_for_brace then
    waiting_for_brace = false
    if vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".")) == "{" then
      return "<CR>}<ESC>O"
    elseif vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".")) == "(" then
      return "<CR>)<ESC>O"
    elseif vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".")) == "[" then
      return "<CR>]<ESC>O"
    elseif vim.fn.getline("."):sub(vim.fn.col(".") - 2, vim.fn.col(".")) == '/*' then
      return "<CR><CR> */<Up> * "
    else
      return "<CR>"
    end
  else
    return "<CR>"
  end
end, { expr = true })

-- reset waiting_for_brace when cursor is moved
vim.api.nvim_create_autocmd('CursorMoved', {
  desc = 'Reset waiting_for_brace when cursor is moved',
  callback = function()
    waiting_for_brace = false
  end,
})

-------------------------
------ COLORSCHEME ------
-------------------------

local transparent_background = function()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'NonText', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalSB', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'Folded', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'SpecialKey', { bg = 'None', ctermbg = 'none' })
  vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'None', ctermbg = 'none' })
end

transparent_background()
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = "*",
  callback = function()
    transparent_background()
  end
})

-- line numbers
vim.opt.number = true
vim.api.nvim_set_hl(0, 'LineNr', { ctermfg = 'gray', fg = 'Gray', bold = false })


-- highlight the cursor line
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLineNr', { ctermfg = 'white', fg = 'white', bold = true })
vim.opt.cursorlineopt = "number"

-- highlight pmenu
vim.api.nvim_set_hl(0, 'Pmenu',
  { ctermfg = 'lightgray', ctermbg = 'black', fg = 'LightGray', bg = 'Black', bold = false })
vim.api.nvim_set_hl(0, 'PmenuSel',
  { ctermfg = 'white', ctermbg = 'darkgray', fg = 'White', bg = 'DarkGray', bold = false })

-- color of matching parenthesis
vim.api.nvim_set_hl(0, 'MatchParen', { ctermbg = 'darkgray', bg = 'DarkGray', bold = true })

-- vimdiff
vim.api.nvim_set_hl(0, 'DiffAdd', { ctermbg = 22, bg = 'DarkGreen' })
vim.api.nvim_set_hl(0, 'DiffChange', { ctermbg = 17, bg = 'NavyBlue' })
vim.api.nvim_set_hl(0, 'DiffDelete', { ctermfg = 'gray', ctermbg = 'none', fg = 'Gray', bg = 'None' })
vim.api.nvim_set_hl(0, 'DiffText', { ctermbg = 52, bg = 'DarkRed' })
