require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",

    -- Search
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
    },

    -- Theme
    "nvim-tree/nvim-web-devicons",
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
        "stevearc/oil.nvim",
        opts = {},
        config = function()
            require("plugins.configs.oil")
        end,
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local highlight = {
                "CursorColumn",
                "Whitespace",
            }
            require("ibl").setup({
                indent = { highlight = highlight, char = "" },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false,
                },
                scope = {
                    enabled = false,
                },
            })
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
        dependencies = "nvim-tree/nvim-web-devicons",
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
            -- Snippet Engine & its associated nvim-cmp source
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            -- Adds LSP completion capabilities
            "hrsh7th/cmp-nvim-lsp",

            -- Adds a number of user-friendly snippets
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lua",
            "jalvesaq/cmp-nvim-r",
        },
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
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.configs.lsp_config")
        end,
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "mason-lspconfig.nvim",
            "lspsaga.nvim",
            "lsp_signature.nvim",
            "folke/neodev.nvim",
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
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
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
        config = function()
            require("plugins.configs.flash_conf")
        end,
    },

    {
        "chentoast/marks.nvim",
        event = "BufReadPre",
        config = function()
            require("marks").setup({})
        end,
    },

    -- Comments
    "tpope/vim-commentary",

    -- Selection
    -- "gcmt/wildfire.vim",
    "jamessan/vim-gnupg",

    -- GPT
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

    -- copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        dependencies = "copilot.lua",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                    -- auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = false,
                    -- auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = "node", -- Node.js version must be > 16.x
                server_opts_overrides = {},
            })
        end,
    },

    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end,
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
