local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end
telescope.setup({
    defaults = {
        file_ignore_patterns = { "node%_modules/.*", ".*/_freeze/.*" },
        find_files = {
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "--glob",
                "!.git/*",
                "--glob",
                "!*/_freeze/*",
                "--sort",
                "path",
            },
        },
    },
})

-- Keymaps
local builtins = require("telescope.builtin")
vim.keymap.set(
    "n",
    "<leader>fl",
    builtins.find_files,
    { silent = true, noremap = true, desc = "Files" }
)

vim.keymap.set(
    "n",
    "<leader>f",
    builtins.live_grep,
    { silent = true, noremap = true, desc = "Grep" }
)

vim.keymap.set(
    "n",
    "<leader>ff",
    builtins.grep_string,
    { silent = true, noremap = true, desc = "Grep word" }
)

vim.keymap.set(
    "n",
    "<leader>fb",
    builtins.buffers,
    { silent = true, noremap = true, desc = "Buffers" }
)

vim.keymap.set(
    "n",
    "<leader>fr",
    builtins.registers,
    { silent = true, noremap = true, desc = "Registers" }
)

vim.keymap.set(
    "n",
    "<leader>fk",
    builtins.keymaps,
    { silent = true, noremap = true, desc = "Keymaps" }
)

vim.keymap.set(
    "n",
    "<leader>fm",
    builtins.marks,
    { silent = true, noremap = true, desc = "marks" }
)
