require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",

    -- Search
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        config = function()
            require("plugins.configs.telescope_conf")
        end,
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
        dependencies = "nvim-tree/nvim-web-devicons",
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
        "szw/vim-maximizer",
        keys = {
            {
                "<leader>sm",
                "<cmd>MaximizerToggle<CR>",
                desc = "Maximize/minimize a split",
            },
        },
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
            vim.keymap.set("n", "<leader>dr", dbt.run)
            vim.keymap.set("n", "<leader>dra", dbt.run_all)
            vim.keymap.set("n", "<leader>dt", dbt.test)
            vim.keymap.set("n", "<leader>fd", require("dbtpal.telescope").dbt_picker)

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
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            "jalvesaq/cmp-nvim-r",
        },
    },

    -- Snippets
    "rafamadriz/friendly-snippets",

    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
    },

    -- Linting
    {
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = true,
            formatters_by_ft = {
                json = { "jq" },
                yaml = { "yamllint" },
                go = { "goimports", "gofmt" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "ruff_fix", "ruff_format" },
                rust = { "rustfmt" },
                bash = { "shfmt", "shellcheck" },
                sh = { "shfmt", "shellcheck" },
                cmake = { "cmake_format" },
                css = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                ["*"] = { "trim_whitespace", "codespell" },
            },
            -- This can also be a function that returns the table.
            format_on_save = {
                -- I recommend these options. See :help conform.format for details.
                lsp_fallback = true,
                timeout_ms = 500,
            },
        },
        init = function()
            vim.keymap.set("n", "<leader>lf", ":lua require('conform').format()<CR>")
        end,
    },

    "tpope/vim-surround",
    -- LSP
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<leader>xx", function()
                require("trouble").toggle()
            end)
            vim.keymap.set("n", "<leader>xn", function()
                -- jump to the next item, skipping the groups
                require("trouble").next({ skip_groups = true, jump = true })
            end)
            vim.keymap.set("n", "<leader>xp", function()
                -- jump to the previous item, skipping the groups
                require("trouble").previous({ skip_groups = true, jump = true })
            end)
            vim.keymap.set("n", "<leader>xw", function()
                require("trouble").toggle("workspace_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xd", function()
                require("trouble").toggle("document_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xq", function()
                require("trouble").toggle("quickfix")
            end)
            vim.keymap.set("n", "<leader>xl", function()
                require("trouble").toggle("loclist")
            end)
            vim.keymap.set("n", "gr", function()
                require("trouble").toggle("lsp_references")
            end)
        end,
        opts = {},
    },

    -- "jay-babu/mason-null-ls.nvim",

    -- LSP
    "towolf/vim-helm",

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
        event = "VeryLazy",
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

    -- Movements
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.configs.flash_conf")
        end,
        keys = {
            {
                "gt",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
        },
    },

    {
        "ThePrimeagen/harpoon",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("plugins.configs.harpoon_conf")
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
    "jamessan/vim-gnupg",

    -- GPT
    -- {
    --     "jackMort/ChatGPT.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("plugins.configs.chatgpt_conf")
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    -- },

    -- -- copilot
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     build = ":Copilot auth",
    --     dependencies = "copilot.lua",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({
    --             panel = {
    --                 enabled = false,
    --                 -- auto_refresh = false,
    --                 keymap = {
    --                     jump_prev = "[[",
    --                     jump_next = "]]",
    --                     accept = "<CR>",
    --                     refresh = "gr",
    --                     open = "<M-CR>",
    --                 },
    --                 layout = {
    --                     position = "bottom", -- | top | left | right
    --                     ratio = 0.4,
    --                 },
    --             },
    --             suggestion = {
    --                 enabled = false,
    --                 -- auto_trigger = true,
    --                 debounce = 75,
    --                 keymap = {
    --                     accept = "<M-l>",
    --                     accept_word = false,
    --                     accept_line = false,
    --                     next = "<M-]>",
    --                     prev = "<M-[>",
    --                     dismiss = "<C-]>",
    --                 },
    --             },
    --             filetypes = {
    --                 yaml = false,
    --                 markdown = false,
    --                 help = false,
    --                 gitcommit = false,
    --                 gitrebase = false,
    --                 hgcommit = false,
    --                 svn = false,
    --                 cvs = false,
    --                 ["."] = false,
    --             },
    --             copilot_node_command = "node", -- Node.js version must be > 16.x
    --             server_opts_overrides = {},
    --         })
    --     end,
    -- },

    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end,
    -- },

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

    -- REPL
    {
        "jpalardy/vim-slime",
        init = function()
            vim.b.slime_cell_delimiter = "# %%"
            vim.g.slime_target = "tmux"
            vim.g.slime_bracketed_paste = 1
            vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
        end,
    },

    {
        "quarto-dev/quarto-nvim",
        config = function()
            require("plugins.configs.quarto_conf")
        end,
        dependencies = {
            {
                "jmbuhr/otter.nvim",
                dev = false,
                dependencies = {
                    { "neovim/nvim-lspconfig" },
                },
                opts = {
                    buffers = {
                        set_filetype = true,
                    },
                },
            },
            opts = {
                lspFeatures = {
                    languages = {
                        "r",
                        "python",
                        "julia",
                        "bash",
                        "lua",
                        "html",
                    },
                },
            },
            "hrsh7th/nvim-cmp",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
    },
})
