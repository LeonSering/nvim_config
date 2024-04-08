-- rendered diagnostics --
local function get_rendered_diagnostic(diagnostic)
  local result = vim.tbl_get(diagnostic, 'user_data', 'lsp', 'data', 'rendered')
  if type(result) == 'string' then
    return result
  end
end

local function render_diagnostic(forward)
  local diagnostics = vim.tbl_filter(function(diagnostic)
    return get_rendered_diagnostic(diagnostic) ~= nil
  end, vim.diagnostic.get(0, {}))
  if #diagnostics == 0 then
    vim.notify('No renderable diagnostics found.', vim.log.levels.INFO)
    return
  end
  -- local win_id = vim.api.nvim_get_current_win()
  local opts = {
    -- cursor_position = vim.api.nvim_win_get_cursor(win_id),
    wrap = true,
    severity = { min = vim.diagnostic.severity.WARN },
  }

  local rendered_diagnostic
  local diagnostic
  local pos_map = {}
  local pos_id = 1
  repeat
    if forward then
      diagnostic = vim.diagnostic.get_next(opts)
    else
      diagnostic = vim.diagnostic.get_prev(opts)
    end
    pos_map[pos_id] = diagnostic
    if diagnostic == nil then
      break
    end
    rendered_diagnostic = get_rendered_diagnostic(diagnostic)
    local pos = { diagnostic.lnum, diagnostic.col }
    pos_id = pos[1] + pos[2]
    -- opts.cursor_position = pos
    local searched_all = pos_map[pos_id] ~= nil
  until diagnostic == nil or rendered_diagnostic ~= nil or searched_all
  if not rendered_diagnostic then
    -- No diagnostics found. Fall back to first result from filter,
    rendered_diagnostic = get_rendered_diagnostic(diagnostics[1])
  end

  -- Save position in the window's jumplist
  vim.cmd("normal! m'")

  -- Move cursor to the diagnostic
  vim.api.nvim_win_set_cursor(0, { diagnostic.lnum + 1, diagnostic.col })

  -- Open folds under the cursor
  vim.cmd('normal! zv')

  local lines = vim.split(rendered_diagnostic, '\n')
  local float_preview_lines = vim.deepcopy(lines)
  vim.schedule(function()
    -- close_hover()
    local bufnr, _ = vim.lsp.util.open_floating_preview(
      float_preview_lines,
      'markdown',
      { border = 'rounded', focusable = false }
    )
    vim.api.nvim_buf_set_option(bufnr, 'filetype', vim.o.filetype)
  end)
end

vim.keymap.set('n', '<leader>e', function() render_diagnostic(true) end, { desc = "Rust: Render next diagnostics" })
vim.keymap.set('n', '<leader>E', function() render_diagnostic(false) end, { desc = "Rust: Render previous diagnostics" })




--- Explain Error ---
local rustc = 'rustc'

local system = vim.system
    or function(cmd, on_exit)
      local output = vim.fn.system(cmd)
      local ok = vim.v.shell_error
      local systemObj = {
        signal = 0,
        stdout = ok and (output or '') or nil,
        stderr = not ok and (output or '') or nil,
        code = vim.v.shell_error,
      }
      if on_exit then
        on_exit(systemObj)
      end
      return systemObj
    end

local function explain_error(forward)
  if vim.fn.executable(rustc) ~= 1 then
    vim.notify('rustc is needed to explain errors.', vim.log.levels.ERROR)
    return
  end

  local diagnostics = vim.tbl_filter(function(diagnostic)
    return diagnostic.code ~= nil
        and diagnostic.source == 'rustc'
        and diagnostic.severity == vim.diagnostic.severity.ERROR
  end, vim.diagnostic.get(0, {}))
  if #diagnostics == 0 then
    vim.notify('No explainable errors found.', vim.log.levels.INFO)
    return
  end

  local win_id = vim.api.nvim_get_current_win()
  local opts = {
    cursor_position = vim.api.nvim_win_get_cursor(win_id),
    severity = vim.diagnostic.severity.ERROR,
    wrap = true,
  }

  local found = false
  local diagnostic
  local pos_map = {}
  local pos_id = 1
  repeat
    if forward then
      diagnostic = vim.diagnostic.get_next(opts)
    else
      diagnostic = vim.diagnostic.get_prev(opts)
    end
    pos_map[pos_id] = diagnostic
    if diagnostic == nil then
      break
    end
    found = diagnostic.code ~= nil --and diagnostic.source == 'rustc'
    local pos = { diagnostic.lnum, diagnostic.col }
    pos_id = pos[1] + pos[2]
    opts.cursor_position = pos
    local searched_all = pos_map[pos_id] ~= nil
  until diagnostic == nil or found or searched_all
  if not found then
    -- Fall back to first diagnostic
    diagnostic = diagnostics[1]
    local pos = { diagnostic.lnum, diagnostic.col }
    opts.cursor_position = pos
    return
  end

  local function handler(sc)
    if sc.code ~= 0 or not sc.stdout then
      vim.notify('Error calling rustc --explain' .. (sc.stderr and ': ' .. sc.stderr or ''), vim.log.levels.ERROR)
      return
    end
    local output = sc.stdout:gsub('```', '```rust', 1)
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(output, {})
    local float_preview_lines = vim.deepcopy(markdown_lines)
    vim.schedule(function()
      -- close_hover()
      local bufnr, _ = vim.lsp.util.open_floating_preview(
        float_preview_lines,
        'markdown',
        { border = 'rounded', focusable = true }
      )
      vim.api.nvim_buf_set_option(bufnr, 'filetype', vim.o.filetype)
    end)
  end

  -- Save position in the window's jumplist
  vim.cmd("normal! m'")

  -- Move cursor to the diagnostic
  vim.api.nvim_win_set_cursor(0, { diagnostic.lnum + 1, diagnostic.col })

  -- Open folds under the cursor
  vim.cmd('normal! zv')

  -- Open the floating window
  system({ rustc, '--explain', tostring(diagnostic.code) }, vim.schedule_wrap(handler))
end


vim.keymap.set('n', '<leader>ce', function() explain_error(true) end, { desc = "Rust: Explain next error" })
vim.keymap.set('n', '<leader>cE', function() explain_error(false) end, { desc = "Rust: Explain previous error" })
vim.keymap.set('n', '<leader>CE', function() explain_error(false) end, { desc = "Rust: Explain previous error" })
