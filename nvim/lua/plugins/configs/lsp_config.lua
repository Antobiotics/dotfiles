local vim = vim
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
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
    buf_set_keymap(
        "n",
        "<leader><C-k>",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        opts
    )

    buf_set_keymap(
        "n",
        "<leader>lf",
        "<cmd>lua vim.lsp.buf.format({async=true})<CR>",
        opts
    )

    require("lsp_signature").on_attach({
        bind = true,
        hint_enable = false,
    }, bufnr)

    client.server_capabilities.document_formatting = true
end

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
})

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
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        capabilities.textDocument.completion.completionItem.snippetSupport =
            true
        local opt = {
            capabilities = capabilities,
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
