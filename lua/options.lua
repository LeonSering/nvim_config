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
vim.opt.undofile = false    -- save undo history between sessions
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.clipboard:append("unnamed") -- yanks into "middle-mouse" clipboard
vim.g.have_nerd_font = true
vim.opt.textwidth = 120
vim.opt.breakindent = true -- auto indent when breaking lines
vim.opt.scrolloff = 4      -- always show lines below coursor
vim.opt.cmdheight = 4      -- height of command line

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


--[[ vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
}) ]]


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

-- load the old vim colorscheme
vim.opt.termguicolors = false
vim.cmd("colorscheme vim")

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

-- diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { ctermfg = 214, fg = 'Orange' })
vim.api.nvim_set_hl(0, 'WarningMsg', { ctermfg = 'black', fg = 'Black', ctermbg = 214, bg = 'Orange' })
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { undercurl = true, sp = 'Orange' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = 'Orange' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = 'Red' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { underline = true, sp = 'Grey62' })

-- todo
vim.api.nvim_set_hl(0, "Todo", { ctermbg = "blue", ctermfg = "black", bg = "Blue", fg = "black", })


-- open at most 4 vertical splits:
local max_splits = 4

-- Function to manage vertical splits
local function manage_splits()
  -- Check if the current tab is the first (leftmost) tab
  local current_tab = vim.api.nvim_get_current_tabpage()
  local all_tabs = vim.api.nvim_list_tabpages()
  table.sort(all_tabs) -- Sort tabs to ensure the first tab is at index 1

  if current_tab ~= all_tabs[1] then
    return -- Exit the function if the current tab is not the first tab
  end

  local new_win_id = vim.api.nvim_get_current_win()             -- The newest window
  local all_windows = vim.api.nvim_tabpage_list_wins(current_tab) -- Get windows for the current tab only

  -- Determine the positions of all windows
  local window_positions = {}
  local new_win_pos = vim.api.nvim_win_get_position(new_win_id)

  for _, win in ipairs(all_windows) do
    local win_config = vim.api.nvim_win_get_config(win)
    if win_config.relative == "" then -- Exclude floating and sidebar windows
      table.insert(window_positions, {
        win_id = win,
        pos = vim.api.nvim_win_get_position(win),
      })
    end
  end

  if #window_positions <= max_splits then
    return
  end

  -- Sort windows by their column positions (left to right)
  table.sort(window_positions, function(a, b)
    return a.pos[2] < b.pos[2]
  end)

  -- Check if the new split is the rightmost window
  local rightmost_window = window_positions[#window_positions]
  if new_win_id == rightmost_window.win_id then
    -- Get the leftmost window
    local leftmost_window = window_positions[1]

    -- Close the leftmost window
    vim.api.nvim_win_close(leftmost_window.win_id, true)

    -- Move the new window to the leftmost position
    vim.cmd("wincmd H") -- Move the current window to the far left
  else
    -- Close the window immediately to the right of the new window
    local target_win_id = nil
    for _, win_info in ipairs(window_positions) do
      if win_info.pos[1] == new_win_pos[1] and win_info.pos[2] > new_win_pos[2] then
        target_win_id = win_info.win_id
        break
      end
    end

    -- Close the target window if it exists and there are at least 4 vertical windows
    if target_win_id then
      vim.api.nvim_win_close(target_win_id, true)
    end
  end
end

-- Autocommand to trigger the function after opening a new window
vim.api.nvim_create_autocmd("WinNew", {
  callback = function()
    manage_splits()
  end,
})
