local trouble = require("trouble")

trouble.setup({
    auto_jump = false,
    auto_preview = false,
    focus = true,
    keys = {
        ["<c-x>"] = "jump_split",
    },
    preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "preview",
        title_pos = "center",
        position = { 0, -3 },
        size = { width = 0.5, height = 0.55 },
        zindex = 200,
        -- size = 0.5,
    },
    win = {
        size = { height = 0.35 },
    },
})
