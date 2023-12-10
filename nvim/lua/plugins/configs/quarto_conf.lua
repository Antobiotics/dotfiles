require("quarto").setup({
    debug = false,
    closePreviewOnExit = true,
    codeRunner = {
        enabled = true,
        default_method = "slime", -- 'molten' or 'slime'
        ft_runners = {
            python = "slime",
            r = "slime",
            bash = "slime",
        },                      -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        never_run = { "yaml" }, -- filetypes which are never sent to a code runner
    },
    lspFeatures = {
        enabled = true,
        languages = { "r", "python", "julia", "bash" },
        chunks = "curly", -- 'curly' or 'all'
        diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
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

vim.keymap.set("n", "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>")
vim.keymap.set(
    "n",
    "<leader>qpq",
    ":lua require'quarto'.quartoClosePreview()<cr>"
)
vim.keymap.set("n", "<leader>qrr", ":QuartoSendAbove<cr>")
vim.keymap.set("n", "<leader>qra", ":QuartoSendAll<cr>")
vim.keymap.set("n", "<leader>qrb", ":QuartoSendBelow<cr>")
vim.keymap.set("n", "<leader>qrl", ":QuartoSendLine<cr>")
vim.keymap.set("n", "<leader>or", "o```{r}<cr>```<esc>O")
vim.keymap.set("n", "<leader>op", "o```{python}<cr>```<esc>O")
