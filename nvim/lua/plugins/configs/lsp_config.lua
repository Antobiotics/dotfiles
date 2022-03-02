local vim = vim
local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = false }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap(
    "n",
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>D",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    opts
  )
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>ca",
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    opts
  )
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>e",
    "<cmd>lua vim.diagnostic.show()<CR>",
    opts
  )
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>q",
    "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    opts
  )
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- local lsp = vim.lsp
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)-- Use a loop to conveniently call 'setup' on multiple servers and

-- map buffer local keybindings when the language server attaches
local defined_servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(defined_servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
end


local util = require('lspconfig/util')
local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, 'Pipfile'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
    return path.join(venv, 'bin', 'python')
  end

  -- Find and use virtualenv via poetry in workspace directory.
  local poetry_match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  if poetry_match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

require'lspconfig'.pyright.setup {
    on_attach = function(client, bufnr)
        require'lsp_signature'.on_attach({
            bind = true,
            hint_enable = false,
        }, bufnr)
    end,
    on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    end
}
