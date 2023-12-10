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
            vim.keymap.set(
                "n",
                "<leader>fd",
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
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
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
        "sbdchd/neoformat",
        cmd = "Neoformat",
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("plugins.configs.nvim_null_ls")
        end,
    },

    "jay-babu/mason-null-ls.nvim",
    { "tpope/vim-surround" },
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
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.keymap.set("n", "<leader>xx", function()
                require("trouble").toggle()
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

    "jay-babu/mason-null-ls.nvim",

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
    -- {
    --     "jpalardy/vim-slime",
    -- },

    -- like ipython, R, bash
    {
        "jpalardy/vim-slime",
        -- init = function()
        --     vim.b["quarto_is_" .. "python" .. "_chunk"] = false
        --     Quarto_is_in_python_chunk = function()
        --         require("otter.tools.functions").is_otter_language_context(
        --             "python"
        --         )
        --     end

        --     vim.cmd([[
        -- let g:slime_dispatch_ipython_pause = 100
        -- function SlimeOverride_EscapeText_quarto(text)
        -- call v:lua.Quarto_is_in_python_chunk()
        -- if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
        -- return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
        -- else
        -- return a:text
        -- end
        -- endfunction
        -- ]])

        --     local function mark_terminal()
        --         vim.g.slime_last_channel = vim.b.terminal_job_id
        --         vim.print(vim.g.slime_last_channel)
        --     end

        --     local function set_terminal()
        --         vim.b.slime_config = { jobid = vim.g.slime_last_channel }
        --     end

        --     vim.b.slime_cell_delimiter = "# %%"

        --     -- slime, neovvim terminal
        --     vim.g.slime_target = "neovim"
        --     vim.g.slime_python_ipython = 1

        --     -- -- slime, tmux
        --     -- vim.g.slime_target = 'tmux'
        --     -- vim.g.slime_bracketed_paste = 1
        --     -- vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }

        --     local function toggle_slime_tmux_nvim()
        --         if vim.g.slime_target == "tmux" then
        --             pcall(function()
        --                 vim.b.slime_config = nil
        --                 vim.g.slime_default_config = nil
        --             end)
        --             -- slime, neovvim terminal
        --             vim.g.slime_target = "neovim"
        --             vim.g.slime_bracketed_paste = 0
        --             vim.g.slime_python_ipython = 1
        --         elseif vim.g.slime_target == "neovim" then
        --             pcall(function()
        --                 vim.b.slime_config = nil
        --                 vim.g.slime_default_config = nil
        --             end)
        --             -- -- slime, tmux
        --             vim.g.slime_target = "tmux"
        --             vim.g.slime_bracketed_paste = 1
        --             vim.g.slime_default_config =
        --             { socket_name = "default", target_pane = ".2" }
        --         end
        --     end

        --     vim.keymap.set(
        --         "n",
        --         "<leader>cm",
        --         mark_terminal,
        --         { desc = "mark_terminal", silent = false }
        --     )

        --     vim.keymap.set(
        --         "n",
        --         "<leader>cs",
        --         set_terminal,
        --         { desc = "set_terminal", silent = false }
        --     )
        --     vim.keymap.set(
        --         "n",
        --         "<leader>ct",
        --         toggle_slime_tmux_nvim,
        --         { desc = "toggle_slime_tmux_nvim", silent = false }
        --     )
        --     -- require("which-key").register({
        --     --     ["<leader>cm"] = { mark_terminal, "mark terminal" },
        --     --     ["<leader>cs"] = { set_terminal, "set terminal" },
        --     --     ["<leader>ct"] = {
        --     --         toggle_slime_tmux_nvim,
        --     --         "toggle tmux/nvim terminal",
        --     --     },
        --     -- })
        -- end,
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

    -- {
    -- "jalvesaq/Nvim-R",
    -- dependencies = {
    --     "jalvesaq/cmp-nvim-r",
    -- },
    -- },
    -- {
    --     -- see the image.nvim readme for more information about configuring this plugin
    --     "3rd/image.nvim",
    --     opts = {
    --         backend = "ueberzug", -- whatever backend you would like to use
    --         max_width = 100,
    --         max_height = 12,
    --         max_height_window_percentage = math.huge,
    --         max_width_window_percentage = math.huge,
    --         window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
    --         window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    --     },
    -- },
    -- {
    --     "benlubas/molten-nvim",
    --     dependencies = { "3rd/image.nvim" },
    --     -- dependencies = { "benlubas/image.nvim", dev = true },
    --     dev = false,
    --     build = ":UpdateRemotePlugins",
    --     init = function()
    --         -- vim.g.molten_show_mimetype_debug = true
    --         vim.g.molten_auto_open_output = false
    --         -- vim.g.molten_image_provider = "image.nvim"
    --         vim.g.molten_output_crop_border = true
    --         -- vim.g.molten_output_show_more = true
    --         vim.g.molten_output_win_border = { "", "━", "", "" }
    --         vim.g.molten_output_win_max_height = 12
    --         -- vim.g.molten_output_virt_lines = true
    --         vim.g.molten_virt_text_output = true
    --         vim.g.molten_use_border_highlights = true
    --         vim.g.molten_virt_lines_off_by_1 = true
    --         vim.g.molten_wrap_output = true

    --         vim.keymap.set(
    --             "n",
    --             "<localleader>mi",
    --             ":MoltenInit<CR>",
    --             { desc = "Initialize Molten", silent = true }
    --         )
    --         vim.keymap.set("n", "<localleader>ir", function()
    --             vim.cmd("MoltenInit rust")
    --         end, {
    --             desc = "Initialize Molten for Rust",
    --             silent = true,
    --         })
    --         vim.keymap.set("n", "<localleader>ip", function()
    --             local venv = os.getenv("VIRTUAL_ENV")
    --             if venv ~= nil then
    --                 -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
    --                 venv = string.match(venv, "/.+/(.+)")
    --                 vim.cmd(("MoltenInit %s"):format(venv))
    --             else
    --                 vim.cmd("MoltenInit python3")
    --             end
    --         end, {
    --             desc = "Initialize Molten for python3",
    --             silent = true,
    --             noremap = true,
    --         })

    --         vim.api.nvim_create_autocmd("User", {
    --             pattern = "MoltenInitPost",
    --             callback = function()
    --                 -- quarto code runner mappings
    --                 local r = require("quarto.runner")
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>rc",
    --                     r.run_cell,
    --                     { desc = "run cell", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>ra",
    --                     r.run_above,
    --                     { desc = "run cell and above", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>rb",
    --                     r.run_below,
    --                     { desc = "run cell and below", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>rl",
    --                     r.run_line,
    --                     { desc = "run line", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>rA",
    --                     r.run_all,
    --                     { desc = "run all cells", silent = true }
    --                 )
    --                 vim.keymap.set("n", "<localleader>RA", function()
    --                     r.run_all(true)
    --                 end, {
    --                     desc = "run all cells of all languages",
    --                     silent = true,
    --                 })

    --                 -- setup some molten specific keybindings
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>e",
    --                     ":MoltenEvaluateOperator<CR>",
    --                     { desc = "evaluate operator", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>rr",
    --                     ":MoltenReevaluateCell<CR>",
    --                     { desc = "re-eval cell", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "v",
    --                     "<localleader>r",
    --                     ":<C-u>MoltenEvaluateVisual<CR>gv",
    --                     { desc = "execute visual selection", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>os",
    --                     ":noautocmd MoltenEnterOutput<CR>",
    --                     { desc = "open output window", silent = true }
    --                 )
    --                 vim.keymap.set(
    --                     "n",
    --                     "<localleader>oh",
    --                     ":MoltenHideOutput<CR>",
    --                     { desc = "close output window", silent = true }
    --                 )
    --                 local open = false
    --                 vim.keymap.set("n", "<localleader>ot", function()
    --                     open = not open
    --                     vim.fn.MoltenUpdateOption("auto_open_output", open)
    --                 end)
    --             end,
    --         })
    --     end,
    -- },
})
