return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- If you use Mason, mason-lspconfig should be here
    -- 'mason-org/mason-lspconfig.nvim',
  },
  config = function()
    -- 1. DISABLE SEMANTIC HIGHLIGHTING
    -- Prevents LSP from overwriting Treesitter colors
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end

    -- 2. STANDARD SERVER SETUP
    local servers = { 'jsonls', 'pyright', 'taplo', 'yamlls', 'marksman' }
    for _, lsp in ipairs(servers) do
      vim.lsp.config[lsp] = {}
      vim.lsp.enable(lsp)
    end

    -- 3. LUA_LS SPECIAL CONFIGURATION
    vim.lsp.config.lua_ls = {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }
    vim.lsp.enable('lua_ls')

    -- 4. GLOBAL DIAGNOSTICS SETTINGS
    vim.diagnostic.config({
      virtual_text = false, -- disable inline diagnostics
      signs = {
        severity = { min = vim.diagnostic.severity.WARN },
        severity_sort = true,
      }
    })

    -- 5. KEYMAPS & INLAY HINTS
    -- set hotkey for formatting
    vim.keymap.set('n', '<leader>p', function() vim.lsp.buf.format { async = true } end, { desc = "LSP: Format" })

    vim.keymap.set('n', '<leader>h', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "LSP: Toggle inlay hints" })

    -- Styling for Inlay Hints (Gray/Italic)
    vim.api.nvim_set_hl(0, 'LspInlayHint', { ctermfg = 103, fg = '#8787af', italic = true })

    -- 6. DISPLAY DIAGNOSTICS IN THE COMMAND BAR

    -- Location information about the last message printed. The format is
    -- `(did print, buffer number, line number)`.
    local last_echo = { false, -1, -1 }

    -- The timer used for displaying a diagnostic in the commandline.
    local echo_timer = nil

    -- The timer after which to display a diagnostic in the commandline.
    local echo_timeout = 0

    -- The highlight group to use for warning messages.
    local warning_hlgroup = 'WarningMsg'

    -- The highlight group to use for error messages.
    local error_hlgroup = 'ErrorMsg'

    -- The highlight group to use for hint messages.
    local hint_hlgroup = 'MsgSeparator'

    -- If the first diagnostic line has fewer than this many characters, also add
    -- the second line to it.
    local short_line_limit = 240

    -- Prints the first diagnostic for the current line.
    local function echo_diagnostic()
      if echo_timer then
        echo_timer:stop()
      end

      echo_timer = vim.defer_fn(
        function()
          local line = vim.fn.line('.') - 1
          local bufnr = vim.api.nvim_win_get_buf(0)

          if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
            return
          end

          local diags = vim.diagnostic.get(0, { lnum = line })

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

          local cmd_lines = vim.api.nvim_get_option_value('cmdheight', {}) - 1

          local chunks = {}
          for i = 1, cmd_lines do
            if #diags < i then
              break
            end
            local diag = diags[i]
            local width = vim.api.nvim_get_option_value('columns', {}) - 25
            local lines = vim.split(diag.message, "\n")
            local message = lines[1]

            if #lines > 1 and #message <= short_line_limit then
              message = message .. ' ' .. lines[2]
            end

            if width > 0 and #message >= width then
              message = message:sub(1, width) .. '...'
            end

            local kind = 'hint'
            local hlgroup = hint_hlgroup
            local padding = '  '

            if diag.severity == vim.diagnostic.severity.ERROR then
              kind = 'error'
              hlgroup = error_hlgroup
              padding = ' '
            elseif diag.severity == vim.diagnostic.severity.WARN then
              kind = 'warn'
              hlgroup = warning_hlgroup
              padding = '  '
            end

            if i < cmd_lines then
              message = message .. '\n'
            elseif #diags > cmd_lines then
              message = message .. '   (' .. (#diags - cmd_lines) .. ' more)'
            end

            local chunk = {
              { kind,              hlgroup },
              { padding .. message }
            }
            chunks = vim.list_extend(chunks, chunk)
          end

          vim.api.nvim_echo(chunks, false, {})
        end,
        echo_timeout
      )
    end

    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      pattern = "*",
      callback = function()
        echo_diagnostic()
      end,
    })
  end
}
