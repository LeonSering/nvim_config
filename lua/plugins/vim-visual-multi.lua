return {
  'mg979/vim-visual-multi',
  init  = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_leader = '<leader><leader>'
    vim.g.VM_maps = {
      ['Find Under'] = '',
      ['Find Subword Under'] = '',
      ['Add Cursor Down'] = '',
      ['Add Cursor Up'] = '',
    }
  end,
  config = function()
    vim.keymap.set('n', '<leader>m', '<Plug>(VM-Find-Under)', {desc='visual-multi: find word'})
    vim.keymap.set('n', '<leader>M', '<Plug>(VM-Select-All)', {desc='visual-multi: find word and select all'})
    vim.keymap.set('x', '<leader>m', '<Plug>(VM-Find-Subword-Under)', {desc='visual-multi: find selection'})
    vim.keymap.set('x', '<leader>M', '<Plug>(VM-Visual-All)', {desc='visual-multi: find selection and select all'})

    vim.keymap.set('n', '<C-Down>', '<Plug>(VM-Add-Cursor-At-Pos)<Down>', {desc='visual-multi: add cursor down'})
    vim.keymap.set('n', '<C-Up>', '<Plug>(VM-Add-Cursor-At-Pos)<Up>', {desc='visual-multi: add cursor up'})
    vim.keymap.set('n', '<C-Left>', '<Plug>(VM-Add-Cursor-At-Pos)<Left>', {desc='visual-multi: add cursor left'})
    vim.keymap.set('n', '<C-Right>', '<Plug>(VM-Add-Cursor-At-Pos)<Right>', {desc='visual-multi: add cursor right'})

    vim.api.nvim_set_hl(0, 'VM_Insert', {ctermbg = 28, bg = 'Green4'})
  end
}
