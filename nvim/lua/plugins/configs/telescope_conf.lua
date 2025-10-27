local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.load_extension("conflicts")
telescope.load_extension("live_grep_args")

local open_with_trouble = require("trouble.sources.telescope").open
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node%_modules/.*",
            ".*/_freeze/.*",
            "poetry.lock",
            ".git/.*",
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--hidden",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
    },
})

local changed_on_branch = function()
    local previewers = require("telescope.previewers")
    local pickers = require("telescope.pickers")
    local sorters = require("telescope.sorters")
    local finders = require("telescope.finders")
    pickers.new({}, {
        results_title = "Modified in current branch",
        finder = finders.new_oneshot_job({
            "git",
            "diff",
            "--name-only",
            "--diff-filter=ACMR",
            "origin...",
        }, {}),
        sorter = sorters.get_fuzzy_file(),
        previewer = previewers.new_termopen_previewer({
            get_command = function(entry)
                return {
                    "git",
                    "diff",
                    "--diff-filter=ACMR",
                    "origin...",
                    "--",
                    entry.value,
                }
            end,
        }),
    })
        :find()
end

local actions = require "telescope.actions"
require("telescope").setup {
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                }
            }
        }
    }
}

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
    telescope.extensions.live_grep_args.live_grep_args,
    { silent = true, noremap = true, desc = "Live Grep (Args)" }
)

vim.keymap.set("n", "<leader>ff", live_grep_args_shortcuts.grep_word_under_cursor, {
    silent = true,
    noremap = true,
    desc = "Word Grep (Args)",
})

vim.keymap.set("n", "<leader>fg", function() changed_on_branch() end,
    { silent = true, noremap = true, desc = "Modified files" })


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
    "<leader>fu",
    builtins.resume,
    { silent = true, noremap = true, desc = "Resume" }
)

vim.keymap.set("n", "<leader>fm", builtins.marks, { silent = true, noremap = true, desc = "marks" })
