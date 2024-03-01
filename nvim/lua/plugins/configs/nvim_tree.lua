local vim = vim
local g = vim.g

require("nvim-tree").setup({
    -- on_attach = on_attach,

    disable_netrw = true,
    hijack_netrw = false,
    update_cwd = false,
    open_on_tab = false,

    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
    },

    git = {
        enable = true,
        ignore = true,
        timeout = 400,
    },

    filters = {
        dotfiles = false,
        custom = {
            ".git",
            "node_modules",
            ".cache",
            ".pyc",
            "__pycache__",
        },
    },

    view = {
        float = {
            enable = false,
            quit_on_focus_loss = true,
        },
    },
})

-- GUI
g.nvim_tree_side = "left"
g.nvim_tree_indent_markers = 1

-- Behaviour
g.nvim_tree_allow_resize = 1

g.nvim_tree_quit_on_open = 0
g.nvim_tree_width = 25

-- GIT
g.nvim_tree_git_hl = 1
-- g.nvim_tree_gitignore = 1

-- View
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_add_trailing = 1

g.nvim_tree_show_icons = {
    folders = 1,
    -- folder_arrows= 1
    files = 1,
    git = 1,
}

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌",
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
}
