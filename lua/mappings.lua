----------------------------
------- KEY MAPPINGS -------
----------------------------

-- INSERT MODE / COMMAND LINE MODE --

-- movement

-- move by display lines (visual up / down) when no count is given
vim.keymap.set({ 'n', 'v' }, 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true })
vim.keymap.set({ 'n', 'v' }, 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true })

local function insert_down()
  local old_cursor = vim.o.guicursor
  vim.o.guicursor = 'a:ver25'
  vim.cmd('normal! gj')
  vim.cmd('startinsert')
  vim.o.guicursor = old_cursor
end

local function insert_up()
  local old_cursor = vim.o.guicursor
  vim.o.guicursor = 'a:ver25'
  vim.cmd('normal! gk')
  vim.cmd('startinsert')
  vim.o.guicursor = old_cursor
end

vim.keymap.set({ 'i', 'c', 't' }, '<C-h>', '<Left>')
vim.keymap.set({ 'i', 'c', 't' }, '<C-l>', '<Right>')
vim.keymap.set({ 'c', 't' }, '<C-j>', '<Down>')
vim.keymap.set({ 'c', 't' }, '<C-k>', '<Up>')

vim.keymap.set('i', '<C-j>', insert_down)
vim.keymap.set('i', '<C-k>', insert_up)
vim.keymap.set('i', '<Down>', insert_down)
vim.keymap.set('i', '<Up>', insert_up)

-- deletion
vim.keymap.set({ 'i', 'c', 't' }, '<C-s>', '<Bs>') -- delete character under cursor
vim.keymap.set('i', '<C-b>',
  function()
    if vim.api.nvim_win_get_cursor(0)[2] == vim.api.nvim_get_current_line():len() then
      return "<C-o>vbd"
    else
      return "<C-o>db"
    end
  end, { expr = true })                                            -- delete previous word
-- default setting: <C-u> delete everthing on the left
vim.keymap.set({ 'i', 'c', 't' }, '<C-x>', '<Del>')                -- delete single char on the right of cursor
vim.keymap.set('i', '<C-w>', '<C-o>dw')                            -- delete next word
vim.keymap.set('i', '<C-a>', '<C-o>d$')                            -- delete to end of line
-- x and X delete character wihout register to unnamed register
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true }) -- delete without yanking
vim.keymap.set("n", "X", '"_X', { noremap = true, silent = true }) -- delete without yanking


-- tab and shift-tab
vim.keymap.set('i', '<S-Tab>', '<C-d>')
vim.keymap.set('x', '<S-Tab>', '<gv<esc>')
vim.keymap.set('x', '<Tab>', '>gv<esc>')
vim.keymap.set('x', '<', '<gv<esc>') -- keep cursor at current position after indent
vim.keymap.set('x', '>', '>gv<esc>') -- keep cursor at current position after indent



-- VISUAL MODE --
vim.keymap.set('x', '<C-c>', '"+y')  -- copy
vim.keymap.set('x', '<C-x>', '"+d')  -- cut
vim.keymap.set('x', 'y', 'ygv<esc>') -- keep cursor at current position after yank
vim.keymap.set('x', '<CR>', 'c')     -- change selection


-- NORMAL MODE --
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')       -- clear search highlight
vim.keymap.set('n', '<Cr>', 'ciw')                        -- change word under cursor
vim.keymap.set('n', '<Bs>', 'ch')                         -- change char left of cursor
vim.keymap.set('n', '<leader><Cr>', 'ci(')                -- change text inside parenthesis
vim.keymap.set('n', '<leader>(', 'ci(')                   -- change text inside parenthesis
vim.keymap.set('n', '<leader>)', 'ci)')                   -- change text inside parenthesis
vim.keymap.set('n', '<leader>[', 'ci[')                   -- change text inside brackets
vim.keymap.set('n', '<leader>]', 'ci]')                   -- change text inside brackets
vim.keymap.set('n', '<leader>{', 'ci{')                   -- change text inside curly brackets
vim.keymap.set('n', '<leader>{', 'ci}')                   -- change text inside curly brackets
vim.keymap.set('n', '<leader><', 'ci<', { desc = "ci<" }) -- change text inside tag
vim.keymap.set('n', '<leader>>', 'ci>', { desc = "ci>" }) -- change text inside tag
vim.keymap.set('n', '<leader>"', 'ci"')                   -- change text inside double quotes
vim.keymap.set('n', "<leader>'", "ci'")                   -- change text inside single quotes
vim.keymap.set('n', '<leader>`', 'ci`')                   -- change text inside double quotes

vim.keymap.set('n', '<leader>?', '<Cmd>vsplit ~/.config/nvim/keymappings.md<CR>', { desc = "Open keymappings.md" })
vim.keymap.set('n', '<leader>/n',
  '<Cmd>! osascript ~/.config/nvim/gotopage.scpt ~/.config/nvim/cheat_sheet.pdf 1<CR><Esc>',
  { desc = "Open cheat_sheet.pdf; page: normal_mode" })
vim.keymap.set('n', '<leader>/s',
  '<Cmd>! osascript ~/.config/nvim/gotopage.scpt ~/.config/nvim/cheat_sheet.pdf 2<CR><Esc>',
  { desc = "Open cheat_sheet.pdf; page: space" })
vim.keymap.set('n', '<leader>/c',
  '<Cmd>! osascript ~/.config/nvim/gotopage.scpt ~/.config/nvim/cheat_sheet.pdf 3<CR><Esc>',
  { desc = "Open cheat_sheet.pdf; page: ctrl" })
vim.keymap.set('n', '<leader>/a',
  '<Cmd>! osascript ~/.config/nvim/gotopage.scpt ~/.config/nvim/cheat_sheet.pdf 4<CR><Esc>',
  { desc = "Open cheat_sheet.pdf; page: alt" })
-- vim.keymap.set('n', '<leader>/n', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 1 &<CR><Esc>',
--   { desc = "Open cheat_sheet.pdf; page: normal_mode" })
-- vim.keymap.set('n', '<leader>/s', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 2 &<CR><Esc>',
--   { desc = "Open cheat_sheet.pdf; page: space" })
-- vim.keymap.set('n', '<leader>/c', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 3 &<CR><Esc>',
--   { desc = "Open cheat_sheet.pdf; page: ctrl" })
-- vim.keymap.set('n', '<leader>/a', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 4 &<CR><Esc>',
--   { desc = "Open cheat_sheet.pdf; page: alt" })
vim.keymap.set('n', '<leader>\\', '<Cmd>vsplit ~/.config/nvim/lua/options.lua<CR>', { desc = "Open options.lua" })
vim.keymap.set('n', '<leader>|', '<Cmd>vsplit ~/.config/nvim/lua/mappings.lua<CR>', { desc = "Open mappings.lua" })
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- move down half a page and center cursor
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- move down half a page and center cursorA


local function save_if_modified()
  if vim.bo.readonly then
    print("Buffer is not writable. Cannot save.")
  elseif vim.bo.modified then
    vim.cmd('w')
  else
    print("Buffer is not modified. No need to save.")
  end
end

-- Update key mappings to use the common function
vim.keymap.set('n', '<leader>w', save_if_modified, { desc = "Write buffer (Save file)" })
vim.keymap.set('n', '<C-s>', save_if_modified, { desc = "Write buffer (Save file)" })
vim.keymap.set('n', '<leader>w', save_if_modified, { desc = "Write buffer (Save file)" })
vim.keymap.set('n', '<C-s>', save_if_modified, { desc = "Write buffer (Save file)" })
vim.keymap.set('n', '<leader>q', function()
  -- Check if the current buffer is of normal type and has a filename
  if vim.bo.buftype == '' and vim.api.nvim_buf_get_name(0) ~= '' then
    -- Get the file path
    local filepath = vim.api.nvim_buf_get_name(0)
    -- Check if the file is writable
    if vim.fn.filewritable(filepath) == 1 then
      -- Check if the buffer has unsaved changes
      if vim.bo.modified then
        -- Save the buffer
        vim.cmd('w')
      end
    else
      print("File is not writable")
    end
  end
  -- Quit the buffer
  vim.cmd('q!')
end, { desc = "Write buffer and quit window" })

-- window control
vim.keymap.set({ 'n', 'i', 'v' }, '<A-q>', '<cmd>wincmd o<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-e>', '<cmd>wincmd R<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-r>', '<cmd>wincmd r<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-t>', '<cmd>wincmd T<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-a>', '<cmd>wincmd W<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-s>', '<cmd>wincmd =<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-d>', '<cmd>wincmd w<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-z>', function()
    if vim.fn.winnr('$') == 1 then
      if vim.fn.tabpagenr('$') == 1 then
        vim.cmd('enew')
      else
        vim.cmd('tabclose')
      end
    else
      vim.cmd('q!')
    end
  end,
  { desc = "quit buffer" }
)


vim.keymap.set({ 'n', 'i', 'v' }, '<A-x>', '<cmd>rightbelow vsplit | enew<CR>')
-- vim.keymap.set({ 'n', 'i', 'v' }, '<A-c>', '<cmd>tabclose<CR>') -- overwritten by nvim-dap
vim.keymap.set({ 'n', 'i', 'v' }, '<A-v>', '<cmd>wincmd v<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-h>', '<cmd>wincmd W<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-j>', '<cmd>wincmd j<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-k>', '<cmd>wincmd k<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-l>', '<cmd>wincmd w<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-m>', '<cmd>tabnext<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-n>', '<cmd>tabprevious<CR>')

-- DISABLE KEYS --
-- disable some unused keys
vim.keymap.set('n', 's', '<Nop>')
vim.keymap.set('n', '!', '<Nop>')
vim.keymap.set({ 'n', 'v' }, 'q:', '<Nop>')
vim.keymap.set('n', 'q/', '<Nop>')
vim.keymap.set('n', 'q?', '<Nop>')
vim.keymap.set('n', 'ZZ', '<Nop>')
vim.keymap.set('n', 'ZQ', '<Nop>')
vim.keymap.set('n', 'gf', '<Nop>')
vim.keymap.set('n', 'gx', '<Nop>')
vim.keymap.set('n', 'gc', '<Nop>')
vim.keymap.set('n', 'gcc', '<Nop>')
vim.keymap.set('i', '<C-z>', '<Nop>')
vim.keymap.set('i', '<C-c>', '<Nop>')
vim.keymap.set('i', '<C-@>', '<Nop>')
vim.keymap.set('i', '<C-i>', '<Nop>')
vim.keymap.set('i', '<C-f>', '<Nop>')

-- disable keys for learning:
-- vim.keymap.set({ 'i', 'v', 'c' }, '<BS>', '<Nop>')    -- disable Backspace in insert mode (use <C-s> instead)
-- vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<Del>', '<Nop>') -- disable Delete in insert mode (use <C-x> instead)
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<Home>', '<Nop>') -- disable Home in insert mode (go to normal mode and use 0 instead)
vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<End>', '<Nop>')  -- disable End in insert mode (go to normal mode use $ instead)
-- vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<Left>', '<Nop>') -- disable Left in insert mode (use <C-h> instead)
-- vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<Down>', '<Nop>') -- disable Down in insert mode (use <C-j> instead)
-- vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<Up>', '<Nop>') -- disable Up in insert mode (use <C-k> instead)
-- vim.keymap.set({ 'n', 'i', 'v', 'c' }, '<Right>', '<Nop>') -- disable Right in insert mode (use <C-l> instead)
