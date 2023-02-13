---@diagnostic disable-next-line: undefined-global
local vim = vim
local keymap = vim.keymap.set
local saga = require("lspsaga")

saga.setup({
  -- error_sign = "",
  -- warn_sign = "",
  -- hint_sign = "",
  -- infor_sign = "",
  -- Options with default value
  -- "single" | "double" | "rounded" | "bold" | "plus"
  border_style = "single",
  --the range of 0 for fully opaque window (disabled) to 100 for fully
  --transparent background. Values between 0-30 are typically most useful.
  saga_winblend = 0,
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = "<C-p>", next = "<C-n>" },
  -- Error, Warn, Info, Hint
  -- use emoji like
  -- { "??", "??", "??", "??" }
  -- or
  -- { "??", "??", "??", "??" }
  -- and diagnostic_header can be a function type
  -- must return a string and when diagnostic_header
  -- is function type it will have a param `entry`
  -- entry is a table type has these filed
  -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
  diagnostic_header = { "😡", "😥", "😤", "😐" },
  -- preview lines above of lsp_finder
  preview_lines_above = 0,
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 10,
  -- use emoji lightbulb in default
  code_action_icon = " ",
  -- if true can press number to execute the codeaction in codeaction window
  code_action_num_shortcut = true,
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = false,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = 20,
    virtual_text = false,
  },
  -- finder icons
  finder_icons = {
    def = "  ",
    ref = "  ",
    link = "➤",
  },
  -- finder do lsp request timeout
  -- if your project big enough or your server very slow
  -- you may need to increase this value
  finder_request_timeout = 1500,
  finder_action_keys = {
    open = { "o", "<CR>" },
    vsplit = "v",
    split = "x",
    tabe = "t",
    quit = { "q", "<ESC>" },
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  definition_action_keys = {
    edit = "<C-c>o",
    vsplit = "<C-c>v",
    split = "<C-c>i",
    tabe = "<C-c>t",
    quit = "q",
  },
  rename_action_quit = "<C-c>",
  rename_in_select = true,
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

-- Winbar config
local function get_file_name(include_path)
  local file_name = require("lspsaga.symbolwinbar").get_file_name()
  if vim.fn.bufname("%") == "" then
    return ""
  end
  if include_path == false then
    return file_name
  end
  -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  local path_list = vim.split(
    string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""),
    sep
  )
  local file_path = ""
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and ""
      or file_path .. cur .. " " .. "%#LspSagaWinbarSep#>%*" .. " %*"
  end
  return file_path .. file_name
end

local function config_winbar_or_statusline()
  local exclude = {
    ["terminal"] = true,
    ["toggleterm"] = true,
    ["prompt"] = true,
    ["NvimTree"] = true,
    ["help"] = true,
  } -- Ignore float windows and exclude filetype
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    vim.wo.winbar = ""
  else
    local ok, lspsaga = pcall(require, "lspsaga.symbolwinbar")
    local sym
    if ok then
      sym = lspsaga.get_symbol_node()
    end
    local win_val = ""
    win_val = get_file_name(true) -- set to true to include path
    if sym ~= nil then
      win_val = win_val .. sym
    end
    vim.wo.winbar = win_val
    -- if work in statusline
    -- vim.wo.stl = win_val
  end
end

local events = { "BufEnter", "BufWinEnter", "CursorMoved" }

--vim.api.nvim_create_autocmd(events, {
--  pattern = "*",
--  callback = function()
--    config_winbar_or_statusline()
--  end,
--})

--vim.api.nvim_create_autocmd("User", {
--  pattern = "LspsagaUpdateSymbol",
--  callback = function()
--    config_winbar_or_statusline()
--  end,
--})
-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

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

-- Show cursor diagnostic
-- keymap(
--   "n",
--   "<leader>cd",
--   "<cmd>Lspsaga show_cursor_diagnostics<CR>",
--   { silent = true }
-- )

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
keymap("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({
    ---@diagnostic disable-next-line: undefined-global
    severity = vim.diagnostic.severity.ERROR,
  })
end, { silent = true })
keymap("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({
    ---@diagnostic disable-next-line: undefined-global
    severity = vim.diagnostic.severity.ERROR,
  })
end, { silent = true })

-- Outline
keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- Float terminal
keymap("n", "<F2>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
keymap("n", "<F1>", "<cmd>Lspsaga open_floaterm lazygit<CR>", {
  silent = true,
})
-- close floaterm
keymap(
  "t",
  "<F2>",
  [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]],
  { silent = true }
)
