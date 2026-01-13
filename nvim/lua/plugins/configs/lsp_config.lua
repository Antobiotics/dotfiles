local vim = vim

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

local function get_python_path(workspace)
    if vim.fn.isdirectory(workspace .. "/.venv") == 1 then
        local ppath = workspace .. "/.venv/bin/python"
        return ppath
    end

    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV or vim.env.PYENV_VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. "/bin/python"
    end

    -- vim.print("Using system python")
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end


local language_servers = {
    "lua_ls",
    "rust_analyzer",
    "ruff",
    "sqlls",
    "bashls",
    "neocmake",
    "pyright",
    -- "basedpyright",
    "harper_ls",
    "jdtls"
}

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = language_servers,
})

vim.lsp.buf_attach_client_options = {
    debounce_text_changes = 150
}

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    signs = true,
    update_in_insert = false,
    underline = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = custom_attach,
})

vim.lsp.config("pyright", {
    capabilities = capabilities,
    on_attach = custom_attach,
    root_dir = vim.fs.dirname(vim.fs.find({
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    }, { upward = true })[1]),
    before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path(config.root_dir)
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
                exclude = { "**/node_modules", "**/__pycache__", "**/build", "**/venv", "**/dist", "**/notebooks", "**/.venv" }
            },
        },
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
        },
    },

})

-- vim.lsp.config('basedpyright', {
--     capabilities = capabilities,
--     on_attach = custom_attach,
--     root_dir = vim.fs.dirname(vim.fs.find({
--         "pyproject.toml",
--         "setup.py",
--         "setup.cfg",
--         "requirements.txt",
--         "Pipfile",
--         "pyrightconfig.json",
--         ".git",
--     }, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })[1]),
--     before_init = function(_, config)
--         config.settings.python.pythonPath = get_python_path(config.root_dir)
--     end,
--     settings = {
--         basedpyright = {
--             analysis = {
--                 autoSearchPaths = true,
--                 diagnosticMode = "openFilesOnly",
--                 useLibraryCodeForTypes = true,
--                 typeCheckingMode = "standard",
--                 exclude = { "**/node_modules", "**/__pycache__", "**/build", "**/venv", "**/dist", "**/notebooks", "**/.venv" }
--             },
--         },
--     },
-- })

vim.lsp.config("ruff", {
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }
})

vim.lsp.config("harper_ls", {
    settings = {
        ["harper-ls"] = {
            userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
            linters = {
                SpellCheck = false,
                SpelledNumbers = false,
                AnA = true,
                SentenceCapitalization = false,
                UnclosedQuotes = true,
                WrongQuotes = false,
                LongSentences = true,
                RepeatedWords = true,
                Spaces = true,
                Matcher = true,
                CorrectNumberSuffix = true
            },
        }
    },
})

vim.lsp.config("jdtls", {
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    },
    root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    -- Remove or fix any workspace_folders setting
    workspace_folders = nil, -- Let it auto-detect
})

vim.lsp.enable(language_servers)
vim.lsp.enable { "ruff", "pyright" }
vim.lsp.enable("harper_ls")
