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
            enabled = false,
            default_method = "molten", -- 'molten' or 'slime'
            ft_runners = {
                python = "molten",
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
        rename = "<leader>lR",
        references = "gr",
    },
})

local runner = require("quarto.runner")
vim.keymap.set(
    "n",
    "<localleader>rc",
    runner.run_cell,
    { desc = "run cell", silent = true }
)
vim.keymap.set(
    "n",
    "<localleader>ra",
    runner.run_above,
    { desc = "run cell and above", silent = true }
)
vim.keymap.set(
    "n",
    "<localleader>rA",
    runner.run_all,
    { desc = "run all cells", silent = true }
)
vim.keymap.set(
    "n",
    "<localleader>rl",
    runner.run_line,
    { desc = "run line", silent = true }
)
vim.keymap.set(
    "v",
    "<localleader>r",
    runner.run_range,
    { desc = "run visual range", silent = true }
)
vim.keymap.set("n", "<localleader>RA", function()
    runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })
