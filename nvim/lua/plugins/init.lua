local present, packer = pcall(require, "plugins.packerInit")

if not present then
  return false
end

local use = packer.use

return packer.startup(function()
  use({
    "nvim-lua/plenary.nvim",
  })

  use({
    "wbthomason/packer.nvim",
    event = "VimEnter",
  })

  use({
    "kyazdani42/nvim-web-devicons",
  })

  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.configs.nvim_tree")
    end,
  })
  use({
    "overcache/NeoSolarized",
    config = function()
      require("plugins.configs.neosolarized")
    end,
  })

  use({
    "RRethy/nvim-base16",
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.indent_blankline")
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugins.configs.colorizer")
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    event = "BufRead",
    config = function()
      require("plugins.configs.treesitter")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.configs.gitsigns")
    end,
  })

  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lsp_config")
    end,
  })

  use({
    "tami5/lspsaga.nvim",
    config = function()
      require("lua.plugins.configs.lspsaga")
    end,
  })

  use({
    "kabouzeid/nvim-lspinstall",
  })

  use({
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.configs.lsp_signature")
    end,
  })

  use({
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  })

  use({
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require("plugins.configs.nvim_cmp")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
  })

  use({
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  })

  use({
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  })

  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  })

  use({
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  })

  use({
    "sbdchd/neoformat",
    cmd = "Neoformat",
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  })

  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  })

  use({
    "preservim/nerdcommenter",
  })

  use({
    "jamessan/vim-gnupg",
  })

  use("gcmt/wildfire.vim")

  use({
    "luochen1990/rainbow",
  })

  -- use("psf/black")
  use("averms/black-nvim")
  use("myusuf3/numbers.vim")

  use({
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup()
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.configs.lualine")
    end,
  })
end)
