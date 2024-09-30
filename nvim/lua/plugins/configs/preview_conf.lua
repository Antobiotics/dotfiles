local gtp = require("goto-preview")
local select_to_edit_map = {
    default = "edit",
    horizontal = "new",
    vertical = "vnew",
    tab = "tabedit",
}

local function open_file(orig_window, filename, cursor_position, command)
    if orig_window ~= 0 and orig_window ~= nil then
        vim.api.nvim_set_current_win(orig_window)
    end
    pcall(vim.cmd, string.format("%s %s", command, filename))
    vim.api.nvim_win_set_cursor(0, cursor_position)
end

local function open_preview(preview_win, type)
    return function()
        local command = select_to_edit_map[type]
        local orig_window = vim.api.nvim_win_get_config(preview_win).win
        local cursor_position = vim.api.nvim_win_get_cursor(preview_win)
        local filename = vim.api.nvim_buf_get_name(0)

        vim.api.nvim_win_close(preview_win, gtp.conf.force_close)
        open_file(orig_window, filename, cursor_position, command)

        local buffer = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_del_keymap(buffer, "n", "<C-v>")
        vim.api.nvim_buf_del_keymap(buffer, "n", "<CR>")
        vim.api.nvim_buf_del_keymap(buffer, "n", "<C-x>")
        vim.api.nvim_buf_del_keymap(buffer, "n", "<C-t>")
    end
end

local function post_open_hook(buf, win)
    vim.keymap.set("n", "<C-v>", open_preview(win, "vertical"), { buffer = buf })
    vim.keymap.set("n", "<CR>", open_preview(win, "default"), { buffer = buf })
    vim.keymap.set("n", "<C-x>", open_preview(win, "horizontal"), { buffer = buf })
    vim.keymap.set("n", "<C-t>", open_preview(win, "tab"), { buffer = buf })
end

require("goto-preview").setup({
    post_open_hook = post_open_hook,
})
