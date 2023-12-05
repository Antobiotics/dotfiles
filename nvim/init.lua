local vim = vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("plugins")

-- source our mappings last(may change)
vim.cmd("source ~/.config/nvim/viml/maps.vim")

-- auto-commands
vim.cmd("source ~/.config/nvim/viml/autocmd.vim")

-- legacy
vim.cmd("source ~/.config/nvim/viml/legacy.vim")

-- plugins
vim.cmd("source ~/.config/nvim/viml/plugins.vim")

-- set theme
vim.cmd("colorscheme base16-gruvbox-light-soft")
