----------------------------
------- KEY MAPPINGS -------
----------------------------

-- INSERT MODE / COMMAND LINE MODE --

-- movement
vim.keymap.set({ 'i', 'c' }, '<C-h>', '<Left>')
vim.keymap.set({ 'i', 'c' }, '<C-j>', '<Down>')
vim.keymap.set({ 'i', 'c' }, '<C-k>', '<Up>')
vim.keymap.set({ 'i', 'c' }, '<C-l>', '<Right>')

-- deletion
vim.keymap.set({ 'i', 'c' }, '<C-s>', '<Bs>') -- delete character under cursor
vim.keymap.set('i', '<C-b>',
  function()
    if vim.api.nvim_win_get_cursor(0)[2] == vim.api.nvim_get_current_line():len() then
      return "<C-o>vbd"
    else
      return "<C-o>db"
    end
  end, { expr = true })                        -- delete previous word
-- default setting: <C-u> delete everthing on the left
vim.keymap.set({ 'i', 'c' }, '<C-x>', '<Del>') -- delete single char on the right of cursor
vim.keymap.set('i', '<C-w>', '<C-o>dw')        -- delete next word
vim.keymap.set('i', '<C-a>', '<C-o>d$')        -- delete to end of line


-- tab and shift-tab
vim.keymap.set('i', '<S-Tab>', '<C-d>')
vim.keymap.set('x', '<S-Tab>', '<gv<esc>')
vim.keymap.set('x', '<Tab>', '>gv<esc>')
vim.keymap.set('x', '<', '<gv<esc>') -- keep cursor at current position after indent
vim.keymap.set('x', '>', '>gv<esc>') -- keep cursor at current position after indent



-- VISUAL MODE --
vim.keymap.set('v', '<C-c>', '"+y')  -- copy
vim.keymap.set('v', '<C-x>', '"+d')  -- cut
vim.keymap.set('v', 'y', 'ygv<esc>') -- keep cursor at current position after yank
vim.keymap.set('v', '<CR>', 'c')     -- change selection


-- NORMAL MODE --
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')       -- clear search highlight
vim.keymap.set('n', '<Cr>', 'ciw')                        -- change word under cursor
vim.keymap.set('n', '<Bs>', 'ch')                         -- change word under cursor
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
vim.keymap.set('n', '<leader>/n', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 1<CR><Esc>', { desc = "Open cheat_sheet.pdf; page: normal_mode" })
vim.keymap.set('n', '<leader>/s', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 2<CR><Esc>', { desc = "Open cheat_sheet.pdf; page: space" })
vim.keymap.set('n', '<leader>/c', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 3<CR><Esc>', { desc = "Open cheat_sheet.pdf; page: ctrl" })
vim.keymap.set('n', '<leader>/a', '<Cmd>! okular ~/.config/nvim/cheat_sheet.pdf --page 4<CR><Esc>', { desc = "Open cheat_sheet.pdf; page: alt" })
vim.keymap.set('n', '<leader>\\', '<Cmd>vsplit ~/.config/nvim/lua/options.lua<CR>', { desc = "Open options.lua" })
vim.keymap.set('n', '<leader>|', '<Cmd>vsplit ~/.config/nvim/lua/mappings.lua<CR>', { desc = "Open mappings.lua" })
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- move down half a page and center cursor
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- move down half a page and center cursorA

vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', { desc = "Save file" })

-- window control
vim.keymap.set({ 'n', 'i', 'v' }, '<A-q>', '<cmd>wincmd o<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-e>', '<cmd>wincmd R<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-r>', '<cmd>wincmd r<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-t>', '<cmd>wincmd T<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-a>', '<cmd>wincmd W<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-s>', '<cmd>wincmd =<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-d>', '<cmd>wincmd w<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-z>', '<cmd>q<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-x>', '<cmd>vsplit vnew<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-c>', '<cmd>tabclose<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-v>', '<cmd>wincmd v<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-h>', '<cmd>wincmd W<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-j>', '<cmd>wincmd j<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-k>', '<cmd>wincmd k<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-l>', '<cmd>wincmd w<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-m>', '<cmd>tabnext<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<A-n>', '<cmd>tabprevious<CR>')

-- DISABLE KEYS --
-- disable some unused keys
vim.keymap.set('n', '!', '<Nop>')
vim.keymap.set({ 'n', 'v' }, 'q:', '<Nop>')
vim.keymap.set('n', 'q/', '<Nop>')
vim.keymap.set('n', 'q?', '<Nop>')
vim.keymap.set('n', 'ZZ', '<Nop>')
vim.keymap.set('n', 'ZQ', '<Nop>')
vim.keymap.set('n', 'gf', '<Nop>')
vim.keymap.set('n', 'gx', '<Nop>')
vim.keymap.set('i', '<C-z>', '<Nop>')
vim.keymap.set('i', '<C-c>', '<Nop>')
vim.keymap.set('i', '<C-@>', '<Nop>')
vim.keymap.set('i', '<C-i>', '<Nop>')
vim.keymap.set('i', '<C-n>', '<Nop>')
vim.keymap.set('i', '<C-f>', '<Nop>')

-- disable keys for learning:
vim.keymap.set({'i','v','c'}, '<BS>', '<Nop>')    -- disable Backspace in insert mode (use <C-s> instead)
vim.keymap.set({'n','i','v','c'}, '<Del>', '<Nop>')   -- disable Backspace in insert mode (use <C-x> instead)
vim.keymap.set({'n','i','v','c'}, '<Home>', '<Nop>')  -- disable Home in insert mode (go to normal mode and use 0 instead)
vim.keymap.set({'n','i','v','c'}, '<End>', '<Nop>')   -- disable Home in insert mode (go to normal mode use $ instead)
vim.keymap.set({'n','i','v','c'}, '<Left>', '<Nop>')  -- disable Left in insert mode (use <C-h> instead)
vim.keymap.set({'n','i','v', 'c'}, '<Down>', '<Nop>')  -- disable Down in insert mode (use <C-j> instead)
vim.keymap.set({'n','i','v', 'c'}, '<Up>', '<Nop>')    -- disable Up in insert mode (use <C-k> instead)
vim.keymap.set({'n','i','v','c'}, '<Right>', '<Nop>') -- disable Right in insert mode (use <C-l> instead)

