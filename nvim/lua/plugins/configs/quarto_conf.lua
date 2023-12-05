require("quarto").setup({
    debug = false,
    closePreviewOnExit = true,
    lspFeatures = {
        enabled = true,
        languages = { "r", "python", "julia", "bash" },
        chunks = "curly", -- 'curly' or 'all'
        diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
        },
        codeRunner = {
            enabled = true,
            default_method = "molten", -- 'molten' or 'slime'
            ft_runners = {
                bash = "slime",
            }, -- filetype to runner, ie. `{ python = "molten" }`.
            -- Takes precedence over `default_method`
            never_run = { "yaml" }, -- filetypes which are never sent to a code runner
        },
        completion = {
            enabled = true,
        },
    },
    keymap = {
        hover = "K",
        definition = "gd",
        rename = "grn",
        references = "gr",
    },
})
