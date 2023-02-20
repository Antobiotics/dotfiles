local present, packer = pcall(require, "plugins.packerInit")

if not present then
    return false
end

local use = packer.use

return packer.startup(function()
    -- Utils
    use({
        "nvim-lua/plenary.nvim",
    })

    use({
        "wbthomason/packer.nvim",
        event = "VimEnter",
    })

    -- Search
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
    })

    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })

    -- Theme
    use({
        "kyazdani42/nvim-web-devicons",
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
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.nvim_tree")
        end,
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
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.configs.gitsigns")
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.lualine_conf")
        end,
    })

    use({
        "luochen1990/rainbow",
    })

    use({
        "myusuf3/numbers.vim",
    })

    -- DBT
    use({
        "cfmeyers/dbt.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "rcarriga/nvim-notify",
        },
    })
    use({
        "~/dev/forks/dbtpal",
        config = function()
            local dbt = require("dbtpal")
            dbt.setup({
                -- Path to the dbt executable
                path_to_dbt = "dbt",

                -- Path to the dbt project, if blank, will auto-detect
                -- using currently open buffer for all sql,yml, and md files
                path_to_dbt_project = "",

                -- Path to dbt profiles directory
                path_to_dbt_profiles_dir = vim.fn.expand("~/.dbt"),

                -- Search for ref/source files in macros and models folders
                extended_path_search = true,

                -- Prevent modifying sql files in target/(compiled|run) folders
                protect_compiled_files = true,
            })

            -- Setup key mappings

            vim.keymap.set("n", "<leader>m", dbt.run)
            vim.keymap.set("n", "<leader>ma", dbt.run_all)
            vim.keymap.set("n", "<leader>mt", dbt.test)
            vim.keymap.set(
                "n",
                "<leader>mm",
                require("dbtpal.telescope").dbt_picker
            )

            -- Enable Telescope Extension
            -- require("telescope").load_extension("dbt_pal")
        end,
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    -- Completion
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.configs.nvim_cmp")
        end,
    })

    use({
        "hrsh7th/cmp-buffer",
    })

    use({
        "hrsh7th/cmp-path",
    })

    use({
        "hrsh7th/cmp-emoji",
    })

    use({})

    use({
        "saadparwaiz1/cmp_luasnip",
    })

    use({
        "hrsh7th/cmp-nvim-lsp",
    })

    use({
        "hrsh7th/cmp-nvim-lua",
    })

    -- Snippets
    use({
        "rafamadriz/friendly-snippets",
    })

    use({
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
    })

    -- Linting
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugins.configs.nvim_null_ls")
        end,
    })

    use({
        "jay-babu/mason-null-ls.nvim",
    })

    -- LSP

    use({
        "williamboman/mason.nvim",
    })

    use({
        "williamboman/mason-lspconfig.nvim",
    })

    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.configs.lsp_config")
        end,
    })

    use({
        "glepnir/lspsaga.nvim",
        config = function()
            require("plugins.configs.lspsaga_conf")
        end,
    })

    use({
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("plugins.configs.lsp_signature")
        end,
    })

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.configs.treesitter")
        end,
    })

    -- REPL
    use({
        "jpalardy/vim-slime",
    })

    use({
        "urbainvaes/vim-ripple",
    })

    -- use({ "lukas-reineke/lsp-format.nvim" })

    use({
        "sbdchd/neoformat",
        cmd = "Neoformat",
    })

    -- use({
    --     "tzachar/cmp-fzy-buffer",
    --     requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
    --     -- after = "nvim-cmp",
    -- })

    -- use({
    -- 'tzachar/cmp-fuzzy-path',
    -- requires = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'},
    -- after = "nvim-cmp",
    -- })

    -- Comments
    use({
        "tpope/vim-commentary",
    })

    -- Selection
    use("gcmt/wildfire.vim")

    use({
        "jamessan/vim-gnupg",
    })

    -- GPT
    use({
        "MunifTanjim/nui.nvim",
    })

    use({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("plugins.configs.chatgpt_conf")
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    })
    -- Black
    use("psf/black")

    -- Github
    use({
        "pwntester/octo.nvim",
        config = function()
            require("plugins.configs.octo_conf")
        end,
    })

    -- DAP
    use("sakhnik/nvim-gdb")

    use({
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.configs.dapcore")
        end,
    })

    use({
        "mfussenegger/nvim-dap-python",
        requires = "mfussenegger/nvim-dap",
    })

    use({
        "theHamsta/nvim-dap-virtual-text",
        requires = "mfussenegger/nvim-dap",
    })

    use({
        "rcarriga/nvim-dap-ui",
        config = function()
            require("plugins.configs.dapui_conf")
        end,
        requires = {
            "mfussenegger/nvim-dap",
            "Pocco81/DAPInstall.nvim",
        },
    })
end)
