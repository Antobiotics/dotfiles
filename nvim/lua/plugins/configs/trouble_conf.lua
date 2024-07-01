local trouble = require("trouble")

trouble.setup({
    auto_jump = false,
    focus = true,
    preview = {
        type = "split",
        relative = "win",
        position = "right",
        size = 0.5,
    },
    win = {
        size = { height = 0.35 },
    },
})
