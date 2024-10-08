---@diagnostic disable: undefined-global
local vim = vim
local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.foldmethod = "manual"
opt.modelines = 0

-- Noise
opt.smartindent = true
opt.autoindent = true
opt.wrap = false

-- Save buffer automatically when changing files
opt.autowrite = true

-- Save buffer every 10 chars typed
opt.updatecount = 10
opt.updatetime = 250

-- Always reload buffer when external changes detected
opt.autoread = true

opt.backspace = "indent,eol,start"
opt.fileformats = "unix,mac,dos" -- Handle Mac and DOS line-endings

-- Scroll when 4 lines from top/bottom
opt.scrolloff = 4

-- swapfiles
vim.opt.swapfile = false

-- GUI
opt.ruler = true
opt.showcmd = true
opt.cursorline = true
opt.number = true
opt.termguicolors = true
vim.o.termguicolors = true
opt.relativenumber = true
opt.colorcolumn = "100"

-- Wildmode
vim.opt.path:append("**")
-- lazy file name tab completion
vim.opt.wildmode = "list:longest,list:full"
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
opt.wildmode = "list:longest,full"
opt.wildignore = {
    "*.o",
    "*.obj",
    "*~ ",
    "*vim/backups",
    "*sass-cache*",
    "*DS_Store*",
    "vendor/rails/**",
    "vendor/cache/**",
    "*.gem",
    "log/**",
    "tmp/**",
    "*.png",
    "*.jpg",
    "*.gif",
    "*DS_Store*",
    ".git",
    ".gitkeep",
    "*.so",
    "*.swp",
    "*.zip",
    "*/.Trash/**",
    "*.pdf",
    "*.dmg",
    "*/Library/**",
    "*/.rbenv/**",
    "*.pyc",
    "eggs/**",
    "*.egg-info/**",
}

-- Show Naughty Chars
opt.list = true
-- opt.listchars="tab:>.,trail:.,extends:#,nbsp:."
opt.listchars = {
    tab = ">.",
    trail = ".",
    extends = "#",
    nbsp = ".",
}

-- Tabulation
-- Tab indentation levels every four columns
opt.tabstop = 4

-- Indent/outdent by four columns
opt.shiftwidth = 4

-- Convert all tabs that are typed into spaces
opt.expandtab = true

-- Always indent/outdent to nearest tabstop
opt.shiftround = true

-- Use shiftwidths at left margin, tabstops everywhere else
opt.smarttab = true

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Visual mode
opt.virtualedit = "block"

-- Theme
opt.background = "light"
