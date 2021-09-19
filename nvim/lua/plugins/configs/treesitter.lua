require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages

  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },

  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
})

local vim = vim
require("nvim-treesitter.highlight")

-- Hack to allow rainbow
local hlmap = vim.treesitter.highlighter.hl_map
hlmap["punctuation.bracket"] = nil