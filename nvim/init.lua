local vim = vim
local cmd = vim.cmd

require("plugins")
cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"

require("options")

-- source our mappings last(may change)
vim.cmd("source ~/.config/nvim/viml/maps.vim")
-- auto-commands
-- vim.cmd("source ~/.config/nvim/viml/autocmd.vim")

