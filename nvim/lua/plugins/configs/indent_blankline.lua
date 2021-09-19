local vim = vim
local g = vim.g

g.indentLine_enabled = 1
g.space_char_blankline = " "

g.show_current_context = true
g.show_trailing_blankline_indent = false
g.show_first_indent_level = false

g.buftype_exclude = {
    "help",
    "terminal"
}
