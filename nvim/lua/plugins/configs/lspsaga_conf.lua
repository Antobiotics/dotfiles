---@diagnostic disable-next-line: undefined-global
local vim = vim
local keymap = vim.keymap.set
local saga = require("lspsaga")

saga.setup({
    -- Options with default value
    -- when cursor in saga window you config these to move
    move_in_saga = { prev = "<C-p>", next = "<C-n>" },
    -- Error, Warn, Info, Hint
    diagnostic_header = { "😡", "😥", "😤", "😐" },
    -- preview lines above of lsp_finder
    preview_lines_above = 0,
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 10,
    ui = {
        theme = "round",
        title = true,
        border = "single",
        winblend = 0,
    },
    -- same as nvim-lightbulb but async
    lightbulb = {
        enable = false,
        enable_in_insert = false,
        cache_code_action = true,
        sign = false,
        update_time = 150,
        sign_priority = 20,
        virtual_text = false,
    },
    finder = {
        default = "def+ref+imp",
        max_height = 0.5,
        keys = {
            open = { "o", "<CR>" },
            vsplit = "<c-v>",
            split = "<c-x>",
            tabe = "<c-t>",
            quit = { "q", "<ESC>" },
        },
    },
    code_action = {
        num_shortcut = true,
        show_server_name = false,
        keys = {
            quit = "q",
            exec = "<CR>",
        },
    },
    definition = {
        edit = "<C-c>o",
        vsplit = "<C-c>v",
        split = "<C-c>x",
        tabe = "<C-c>t",
        quit = "q",
    },
    diagnostic = {
        show_code_action = true,
        show_source = true,
        jump_num_shortcut = true,
        --1 is max
        max_width = 0.7,
        custom_fix = nil,
        custom_msg = nil,
        text_hl_follow = false,
        border_follow = true,
        keys = {
            exec_action = "o",
            quit = "q",
            go_action = "g",
        },
    },
    rename = {
        quit = "<C-c>",
        exec = "<CR>",
        mark = "x",
        confirm = "<CR>",
        in_select = true,
    },
    -- show symbols in winbar must nightly
    -- in_custom mean use lspsaga api to get symbols
    -- and set it to your custom winbar or some winbar plugins.
    -- if in_cusomt = true you must set in_enable to false
    symbol_in_winbar = {
        in_custom = true,
        enable = true,
        separator = "| ",
        show_file = true,
        folder_level = 3,
        color_mode = true,
        respect_root = false,
        -- define how to customize filename, eg: %:., %
        -- if not set, use default value `%:t`
        -- more information see `vim.fn.expand` or `expand`
        -- ## only valid after set `show_file = true`
        file_formatter = "%:t",
        click_support = false,
    },
    -- show outline
    show_outline = {
        win_position = "right",
        --set special filetype win that outline window split.like NvimTree neotree
        -- defx, db_ui
        win_with = "",
        win_width = 30,
        auto_enter = false, -- true
        auto_preview = false,
        virt_text = "┃",
        jump_key = "o",
        -- auto refresh when change buffer
        auto_refresh = true,
    },
    -- custom lsp kind
    -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
    custom_kind = {},
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = { metals = { "sbt", "scala" } }
    server_filetype_map = {},
})

keymap("n", "gf", "<cmd>Lspsaga finder<CR>", { silent = true })
-- Code action
keymap(
    { "n", "v" },
    "<leader>ca",
    "<cmd>Lspsaga code_action<CR>",
    { silent = true }
)

-- Rename
keymap("n", "grn", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap(
    "n",
    "<leader>cd",
    "<cmd>Lspsaga show_line_diagnostics<CR>",
    { silent = true }
)

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Hover Doc
keymap(
    "n",
    "K",
    "<cmd>Lspsaga hover_doc<CR>",
    { silent = true, desc = "Hover Documentation" }
)
