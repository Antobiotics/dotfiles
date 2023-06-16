local vim = vim
local quarto = require("quarto")

quarto.setup({
    debug = false,
    closePreviewOnExit = true,
    lspFeatures = {
        enabled = true,
        languages = { "r", "python", "julia", "bash", "lua" },
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
    },
})

vim.keymap.set(
    "n",
    "<leader>qs",
    "<cmd>QuartoActivate<cr>",
    { silent = false, noremap = true }
)

vim.keymap.set(
    "n",
    "<leader>qp",
    quarto.quartoPreview,
    { silent = false, noremap = true }
)

vim.keymap.set(
    "n",
    "<leader>qq",
    quarto.quartoClosePreview,
    { silent = false, noremap = true }
)

vim.keymap.set(
    "n",
    "<leader>qh",
    "<cmd>QuartoHelp<cr>",
    { silent = false, noremap = true }
)

vim.keymap.set(
    "n",
    "<leader>qr",
    "<cmd>QuartoSendAbove<cr>",
    { silent = false, noremap = true }
)

vim.keymap.set(
    "n",
    "<leader>qa",
    "<cmd>QuartoSendAll<cr>",
    { silent = false, noremap = true }
)

vim.keymap.set(
    "n",
    "<leader>qe",
    "<cmd>lua require'otter'.export<cr>",
    { silent = false, noremap = true }
)
-- E = { ":lua require'otter'.export(true)<cr>", 'export overwrite' },
