require("lsp_signature").setup({
    bind = true,
    doc_lines = 2,
    floating_window = false,
    always_trigger = false,
    fix_pos = false,
    transparency = 25,
    floating_window_above_cur_line = false,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 22,
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
        border = "single", -- double, single, shadow, none
    },
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
})
