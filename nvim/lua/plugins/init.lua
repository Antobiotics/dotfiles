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
    "jalvesaq/cmp-nvim-r",

    -- Snippets
    "rafamadriz/friendly-snippets",

    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
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
        "nvimdev/lspsaga.nvim",
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

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },

    -- REPL
    {
        "jpalardy/vim-slime",
        init = function()
            Quarto_is_in_python_chunk = function()
                require("otter.tools.functions").is_otter_language_context(
                    "python"
                )
            end

            vim.cmd([[
        function SlimeOverride_EscapeText_quarto(text)
        call v:lua.Quarto_is_in_python_chunk()
        if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
        return ["%cpaste -q", "\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
        else
        return a:text
        end
        endfunction
        ]])

            vim.b.slime_cell_delimiter = "# %%"

            -- slime, neovvim terminal
            vim.g.slime_target = "neovim"
            vim.g.slime_python_ipython = 1
        end,
    },

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

    -- Movements
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },

    -- Comments
    "tpope/vim-commentary",

    -- Selection
    "gcmt/wildfire.vim",
    "jamessan/vim-gnupg",

    -- GPT
    "MunifTanjim/nui.nvim",

    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
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

    {
        "quarto-dev/quarto-nvim",
        config = function()
            require("plugins.configs.quarto_conf")
        end,
        dependencies = {
            "jmbuhr/otter.nvim",
            "hrsh7th/nvim-cmp",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
    },

    {
        "jalvesaq/Nvim-R",
        dependencies = {
            "jalvesaq/cmp-nvim-r",
        },
    },
})
