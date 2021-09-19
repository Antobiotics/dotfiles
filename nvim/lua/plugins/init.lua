local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
    use {
        "nvim-lua/plenary.nvim",
    }

    use {
        "wbthomason/packer.nvim",
        event = "VimEnter",
    }

    use {
        "kyazdani42/nvim-web-devicons",
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require "plugins.configs.nvim_tree"
        end,
    }

    use {
        "overcache/NeoSolarized",
        config = function()
            require "plugins.configs.neosolarized"
        end,
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            require "plugins.configs.indent_blankline"
        end,
    }

    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function()
            require "plugins.configs.colorizer"
        end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        branch = "0.5-compat",
        event = "BufRead",
        config = function()
            require "plugins.configs.treesitter"
        end,
    }

end)
