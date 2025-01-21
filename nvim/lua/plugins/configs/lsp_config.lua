local vim = vim
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

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
    buf_set_keymap("n", "<leader><C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set(
        "n",
        "gp",
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        { noremap = true }
    )
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    buf_set_keymap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    buf_set_keymap("n", "lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    buf_set_keymap("n", "la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

    buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)

    client.server_capabilities.document_formatting = true
end

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
})

local language_servers = {
    "lua_ls",
    "rust_analyzer",
    "ruff",
    "sqlls",
    "bashls",
    "r_language_server",
    "neocmake",
    "pyright",
}
require("mason-lspconfig").setup({
    ensure_installed = language_servers,
})

require("mason-lspconfig").setup_handlers({
    function(server)
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local opt = {
            capabilities = capabilities,
            on_attach = custom_attach,
        }
        lspconfig[server].setup(opt)
    end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

local lsp_flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}

lspconfig.r_language_server.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        r = {
            lsp = {
                rich_documentation = false,
            },
        },
    },
})

lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = custom_attach,
    root_dir = util.root_pattern(
        "setup.py",
        "setup.cfg",
        "pyproject.toml",
        "poetry.lock",
        "requirements.txt",
        "requirements.lock",
        "Pipfile",
        ".git"
    ),
    on_new_config = function(config, _)
        local python_path = "python"
        local virtual_env = vim.env.VIRTUAL_ENV or vim.env.PYENV_VIRTUAL_ENV
        if virtual_env then
            python_path = require("lspconfig.util").path.join(virtual_env, "bin", "python")
        else
            -- if there is a .venv directory in the project root_dir, use that
            if vim.fn.isdirectory(".venv") == 1 then
                local path = util.path
                python_path = path.join(".venv", "bin", "python")
            end
        end
        config.settings.python.pythonPath = python_path
    end,
    flags = {
        debounce_text_changes = 1,
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
    },
})

lspconfig.ruff.setup({
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = lsp_flags,
})

local configs = require("lspconfig.configs")
if not configs.helm_ls then
    configs.helm_ls = {
        default_config = {
            cmd = { "helm_ls", "serve" },
            filetypes = { "helm" },
            root_dir = function(fname)
                return util.root_pattern("Chart.yaml")(fname)
            end,
        },
    }
end

lspconfig.helm_ls.setup({
    filetypes = { "helm" },
    cmd = { "helm_ls", "serve" },
})
