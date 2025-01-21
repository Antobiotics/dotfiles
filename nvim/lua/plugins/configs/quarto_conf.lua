require("quarto").setup({
    debug = false,
    ft = { "quarto" },
    closePreviewOnExit = true,
    codeRunner = {
        enabled = true,
        default_method = "slime",
        -- ft_runners = {
        --     python = "slime",
        --     r = "slime",
        --     bash = "slime",
        -- }, -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        never_run = { "yaml" }, -- filetypes which are never sent to a code runner
    },
    lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "r", "python", "julia", "bash", "html" },
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
vim.keymap.set("n", "<leader>qpq", ":lua require'quarto'.quartoClosePreview()<cr>")
vim.keymap.set("n", "<leader>qrr", ":QuartoSendAbove<cr>")
vim.keymap.set("n", "<leader>qra", ":QuartoSendAll<cr>")
vim.keymap.set("n", "<leader>qrb", ":QuartoSendBelow<cr>")
vim.keymap.set("n", "<leader>qrl", ":QuartoSendLine<cr>")
vim.keymap.set("n", "<leader>or", "o```{r}<cr>```<esc>O")
vim.keymap.set("n", "<leader>op", "o```{python}<cr>```<esc>O")

local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set(
    "n",
    "<localleader>ra",
    runner.run_above,
    { desc = "run cell and above", silent = true }
)
vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set(
    "v",
    "<localleader>rs",
    runner.run_range,
    { desc = "run visual range", silent = true }
)
vim.keymap.set("n", "<localleader>RA", function()
    runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })
