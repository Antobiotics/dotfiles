require("indent_blankline").setup({
  indentLine_enabled = 1,
  space_char_blankline = " ",

  show_current_context = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,

  buftype_exclude = {
    "help",
    "terminal",
  },
})
