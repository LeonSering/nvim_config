return {
  'j-hui/fidget.nvim', -- shows loading process of lsp
  opts = {
    notification = {
      window = {
        -- Add nvim-tree to avoid list (prevents overlap with file explorer)
        avoid = { 'NvimTree' },
      },
    },
  },
}
