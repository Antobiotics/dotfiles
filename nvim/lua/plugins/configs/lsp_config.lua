local vim = vim
local lsp_config = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_attach = function(client, bufnr)
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
    buf_set_keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)

    buf_set_keymap(
        "n",
        "<space>q",
        "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
        opts
    )
    buf_set_keymap(
        "n",
        "<space>f",
        "<cmd>lua vim.lsp.buf.format({async=true})<CR>",
        opts
    )

    require("lsp_signature").on_attach({
        bind = true,
        hint_enable = false,
    }, bufnr)
end

require("mason").setup()
require("mason-lspconfig").setup()
local language_servers = {
    "lua_ls",
    "rust_analyzer",
    -- "ruff_lsp",
    "sqlls",
    "bashls",
    "r_language_server",
    "neocmake",
    -- "pyright",
}
require("mason-lspconfig").setup({
    ensure_installed = language_servers,
})

require("mason-lspconfig").setup_handlers({
    function(server)
        local opt = {
            capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            ),
            on_attach = custom_attach,
        }
        require("lspconfig")[server].setup(opt)
    end,
})

require("mason-null-ls").setup({
    ensure_installed = {
        "stylua",
        "jq",
        "eslint",
        -- "mypy",
        -- "pylint",
        -- "black",
        -- "ruff",
        "rustfmt",
        "sqlfluff",
    },
    automatic_installation = true,
    automatic_setup = true,
})

for _, lsp in ipairs(language_servers) do
    lsp_config[lsp].setup({
        on_attach = custom_attach,
    })
end

local util = require("lspconfig/util")
local path = util.path

local function get_python_path(workspace)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Find and use virtualenv from pipenv in workspace directory.
    local match = vim.fn.glob(path.join(workspace, "Pipfile"))
    if match ~= "" then
        local venv = vim.fn.trim(
            vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv")
        )
        return path.join(venv, "bin", "python")
    end

    -- Find and use virtualenv via poetry in workspace directory.
    local poetry_match = vim.fn.glob(path.join(workspace, "poetry.lock"))
    if poetry_match ~= "" then
        local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
        return path.join(venv, "bin", "python")
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

-- require("lspconfig").pyright.setup({
--     on_attach = custom_attach,
--     on_init = function(client)
--         client.config.settings.python.pythonPath =
--             get_python_path(client.config.root_dir)
--     end,
--     settings = {
--         pyright = { autoImportCompletion = true },
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 diagnosticMode = "off",
--                 -- diagnosticMode = "openFilesOnly",
--                 useLibraryCodeForTypes = true,
--                 typeCheckingMode = "off",
--             },
--         },
--     },
-- })

-- require("lspconfig").ruff_lsp.setup({
--     on_attach = custom_attach,
--     on_init = function(client)
--         client.config.settings.python.pythonPath =
--             get_python_path(client.config.root_dir)
--     end,
-- })

require("lspconfig").lua_ls.setup({ on_attach = custom_attach })
