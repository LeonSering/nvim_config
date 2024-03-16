return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Setup language servers.
    local lspconfig = require('lspconfig')

    -- disable semantic highlighting for all languages
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end

    lspconfig.rust_analyzer.setup {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            command = 'clippy',
          },
        },
      },
    }

    lspconfig.jsonls.setup {}

    lspconfig.pyright.setup {}

    lspconfig.lua_ls.setup {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
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
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }

    require 'lspconfig'.taplo.setup {} -- TOML

    require 'lspconfig'.yamlls.setup {}

    -- Set up diagnostics.
    vim.diagnostic.config({
      virtual_text = false, -- disable inline diagnostics
      signs = true,
    })

    -- set hotkey for formatting
    vim.keymap.set('n', '<leader>p', function() vim.lsp.buf.format { async = true } end, { desc = "LSP: Format" })

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
          { kind,          hlgroup },
          { ' ' .. message },
        }
        vim.api.nvim_echo(chunks, false, {})
      end, echo_timeout)
    end
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      pattern = "*",
      callback = function()
        echo_diagnostic()
      end,
    })
  end
}
