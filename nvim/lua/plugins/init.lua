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
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
        },
    },

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
    {
        "folke/flash.nvim",
        event = "VeryLazy",
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
                mode = { "n", "x", "o" },
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
        event = "VeryLazy",
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
        "sbdchd/neoformat",
        cmd = "Neoformat",
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

    -- REPL
    "jpalardy/vim-slime",

    {
        "quarto-dev/quarto-nvim",
        dev = false,
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
            },
        },
    },

    {
        "benlubas/molten-nvim",
        dependencies = { "3rd/image.nvim" },
        -- dependencies = { "benlubas/image.nvim", dev = true },
        dev = false,
        build = ":UpdateRemotePlugins",
        init = function()
            -- vim.g.molten_show_mimetype_debug = true
            vim.g.molten_auto_open_output = false
            -- vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_crop_border = true
            -- vim.g.molten_output_show_more = true
            vim.g.molten_output_win_border = { "", "━", "", "" }
            vim.g.molten_output_win_max_height = 12
            -- vim.g.molten_output_virt_lines = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_use_border_highlights = true
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_wrap_output = true

            vim.keymap.set(
                "n",
                "<localleader>mi",
                ":MoltenInit<CR>",
                { desc = "Initialize Molten", silent = true }
            )
            vim.keymap.set("n", "<localleader>ir", function()
                vim.cmd("MoltenInit rust")
            end, {
                desc = "Initialize Molten for Rust",
                silent = true,
            })
            vim.keymap.set("n", "<localleader>ip", function()
                local venv = os.getenv("VIRTUAL_ENV")
                if venv ~= nil then
                    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
                    venv = string.match(venv, "/.+/(.+)")
                    vim.cmd(("MoltenInit %s"):format(venv))
                else
                    vim.cmd("MoltenInit python3")
                end
            end, {
                desc = "Initialize Molten for python3",
                silent = true,
                noremap = true,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MoltenInitPost",
                callback = function()
                    -- quarto code runner mappings
                    local r = require("quarto.runner")
                    vim.keymap.set(
                        "n",
                        "<localleader>rc",
                        r.run_cell,
                        { desc = "run cell", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>ra",
                        r.run_above,
                        { desc = "run cell and above", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>rb",
                        r.run_below,
                        { desc = "run cell and below", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>rl",
                        r.run_line,
                        { desc = "run line", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>rA",
                        r.run_all,
                        { desc = "run all cells", silent = true }
                    )
                    vim.keymap.set("n", "<localleader>RA", function()
                        r.run_all(true)
                    end, {
                        desc = "run all cells of all languages",
                        silent = true,
                    })

                    -- setup some molten specific keybindings
                    vim.keymap.set(
                        "n",
                        "<localleader>e",
                        ":MoltenEvaluateOperator<CR>",
                        { desc = "evaluate operator", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>rr",
                        ":MoltenReevaluateCell<CR>",
                        { desc = "re-eval cell", silent = true }
                    )
                    vim.keymap.set(
                        "v",
                        "<localleader>r",
                        ":<C-u>MoltenEvaluateVisual<CR>gv",
                        { desc = "execute visual selection", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>os",
                        ":noautocmd MoltenEnterOutput<CR>",
                        { desc = "open output window", silent = true }
                    )
                    vim.keymap.set(
                        "n",
                        "<localleader>oh",
                        ":MoltenHideOutput<CR>",
                        { desc = "close output window", silent = true }
                    )
                    local open = false
                    vim.keymap.set("n", "<localleader>ot", function()
                        open = not open
                        vim.fn.MoltenUpdateOption("auto_open_output", open)
                    end)
                end,
            })
        end,
    },
    {
        "jpalardy/vim-slime",
        init = function()
            vim.g.slime_target = "neovim"
        end,
    },
})
