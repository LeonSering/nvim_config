return {
  "https://github.com/RRethy/vim-illuminate",
  config = function()
    -- default configuration
    require('illuminate').configure({
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        'lsp',
        'treesitter',
        -- 'regex',
      },
      -- delay: delay in milliseconds
      delay = 100,
      -- under_cursor: whether or not to illuminate under the cursor
      under_cursor = true,
      -- large_file_cutoff: number of lines at which to use large_file_config
      -- The `under_cursor` option is disabled when this cutoff is hit
      large_file_cutoff = nil,
      -- large_file_config: config to use for large files (based on large_file_cutoff).
      -- Supports the same keys passed to .configure
      -- If nil, vim-illuminate will be disabled for large files.
      large_file_overrides = nil,
      -- min_count_to_highlight: minimum number of matches required to perform highlighting
      min_count_to_highlight = 2,
      -- case_insensitive_regex: sets regex case sensitivity
      case_insensitive_regex = false,
    })

    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = 'Black', ctermbg = 'black', bold = true })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = 'Black', ctermbg = 'black', bold = true })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = 'Black', ctermbg = 'black', bold = true })
  end
}
