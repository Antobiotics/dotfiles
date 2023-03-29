require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",

    -- Search
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },

    -- Theme
    "kyazdani42/nvim-web-devicons",
    "RRethy/nvim-base16",
    "luochen1990/rainbow",
    "myusuf3/numbers.vim",
    {
        "overcache/NeoSolarized",
        config = function()
            require("plugins.configs.neosolarized")
        end,
    },

    {
        "kyazdani42/nvim-tree.lua",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.nvim_tree")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = function()
            require("plugins.configs.indent_blankline")
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function()
            require("plugins.configs.colorizer")
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.configs.gitsigns")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.configs.lualine_conf")
        end,
    },

    -- DBT
    {
        "cfmeyers/dbt.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "rcarriga/nvim-notify",
        },
    },

    {
        "PedramNavid/dbtpal",
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
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("plugins.configs.nvim_cmp")
        end,
        -- event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "cmp-nvim-lsp",
            "cmp_luasnip",
            "cmp-buffer",
            "cmp-path",
            "cmp-emoji",
        },
    },

    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-emoji",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- Snippets
    "rafamadriz/friendly-snippets",

    {
        "L3MON4D3/LuaSnip",
        -- wants = "friendly-snippets",
    },

    -- Linting
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugins.configs.nvim_null_ls")
        end,
    },

    "jay-babu/mason-null-ls.nvim",

    -- LSP

    "williamboman/mason.nvim",

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.configs.lsp_config")
        end,
        dependencies = {
            "mason-lspconfig.nvim",
            "lspsaga.nvim",
            "lsp_signature.nvim",
        },
        lazy = false,
    },

    {
        "glepnir/lspsaga.nvim",
        config = function()
            require("plugins.configs.lspsaga_conf")
        end,
        lazy = false,
    },

    {
        "ray-x/lsp_signature.nvim",
        lazy = false,
        config = function()
            require("plugins.configs.lsp_signature_conf")
        end,
    },

    -- treesitter
    "mrjones2014/nvim-ts-rainbow",
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.configs.treesitter_conf")
        end,
    },

    -- REPL
    "jpalardy/vim-slime",
    "urbainvaes/vim-ripple",

    {
        "sbdchd/neoformat",
        cmd = "Neoformat",
    },

    -- {
    --     "tzachar/cmp-fzy-buffer",
    --     dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
    --     -- after = "nvim-cmp",
    -- },

    -- {
    -- 'tzachar/cmp-fuzzy-path',
    -- dependencies = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'},
    -- after = "nvim-cmp",
    -- },

    -- Comments
    "tpope/vim-commentary",

    -- Selection
    "gcmt/wildfire.vim",
    "jamessan/vim-gnupg",

    -- GPT
    "MunifTanjim/nui.nvim",

    {
        "jackMort/ChatGPT.nvim",
        config = function()
            require("plugins.configs.chatgpt_conf")
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    -- Black
    "psf/black",

    -- Github

    "tpope/vim-fugitive",

    {
        "pwntester/octo.nvim",
        config = function()
            require("plugins.configs.octo_conf")
        end,
    },

    -- DAP
    "sakhnik/nvim-gdb",

    {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.configs.dapcore")
        end,
    },

    {
        "mfussenegger/nvim-dap-python",
        dependencies = "mfussenegger/nvim-dap",
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = "mfussenegger/nvim-dap",
    },

    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require("plugins.configs.dapui_conf")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "Pocco81/DAPInstall.nvim",
        },
    },
})
