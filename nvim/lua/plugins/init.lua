require("lazy").setup({
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "tpope/vim-repeat",

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
            { "Snikimonkd/telescope-git-conflicts.nvim" },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
    },

    -- Theme
    "nvim-tree/nvim-web-devicons",
    "RRethy/nvim-base16",
    "luochen1990/rainbow",
    "myusuf3/numbers.vim",

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

    -- Completion
    {
        "saghen/blink.cmp",
        -- Optional: provides snippets for the snippet source
        dependencies = {
            "rafamadriz/friendly-snippets",
            "moyiz/blink-emoji.nvim",
            "giuxtaposition/blink-cmp-copilot",
        },

        version = "*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "enter",

                ["<C-y>"] = { "select_and_accept" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
            },
            signature = {
                enabled = true,
                window = { border = "rounded" },
            },

            completion = {
                accept = { auto_brackets = { enabled = false }, },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    treesitter_highlighting = true,
                    window = { border = "rounded" },
                },
                ghost_text = {
                    enabled = true,
                },
                trigger = {
                    -- show_on_keyword = true,
                    -- show_on_trigger_character = true,
                    show_on_insert_on_trigger_character = false,
                },
                menu = {
                    auto_show = true,
                    draw = {
                        treesitter = { "lsp" },
                    },
                    cmdline_position = function()
                        if vim.g.ui_cmdline_pos ~= nil then
                            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                            return { pos[1] - 1, pos[2] }
                        end
                        local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                        return { vim.o.lines - height, 0 }
                    end,
                },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer", "copilot", "emoji" },
                -- cmdline = function()
                --     local type = vim.fn.getcmdtype()
                --     if type == "/" or type == "?" then
                --         return { "buffer" }
                --     end
                --     if type == ":" then
                --         return { "cmdline" }
                --     end
                --     return {}
                -- end,
                providers = {
                    cmdline = {
                        min_keyword_length = 2,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15,        -- Tune by preference
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                    },
                    path = {
                        name = "Path",
                        module = "blink.cmp.sources.path",
                        score_offset = 3,
                        fallbacks = { "buffer" },
                        opts = {
                            trailing_slash = false,
                            label_trailing_slash = true,
                            get_cwd = function(context)
                                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                            end,
                            show_hidden_files_by_default = true,
                        },
                    },
                    buffer = {
                        name = "Buffer",
                        module = "blink.cmp.sources.buffer",
                        enabled = true,
                        min_keyword_length = 3,
                        score_offset = 15,
                    },
                },
            },
        },
        opts_extend = { "sources.default", "sources.compat" },
    },

    -- Snippets
    "rafamadriz/friendly-snippets",

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

    -- LSP
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.configs.trouble_conf")
        end,
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>cd",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xl",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
            {
                "gr",
                "<cmd>Trouble lsp toggle focus=true auto_refresh=false<cr>",
                desc = "References (Trouble)",
            },
        },
    },

    {
        "rmagatti/goto-preview",
        event = "BufEnter",
        config = function()
            require("plugins.configs.preview_conf")
        end,
    },

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
            "saghen/blink.cmp",
            "mason-lspconfig.nvim",
            "folke/neodev.nvim",
        },
        lazy = false,
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
    -- Commenting with e.g. `gcc` or `gcip`
    -- respects TS, so it works in quarto documents
    {
        "numToStr/Comment.nvim",
        version = nil,
        branch = "master",
        config = true,
    },
    -- mini
    { "tpope/vim-surround" },
    { "tpope/vim-unimpaired" },
    { "jamessan/vim-gnupg" },

    -- copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },

    -- GitHub
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            "sindrets/diffview.nvim", -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true,
    },
    { "almo7aya/openingh.nvim" },

    -- REPL
    { "jamespeapen/Nvim-R" },
    {
        "jpalardy/vim-slime",
        init = function()
            vim.b["quarto_is_python_chunk"] = false
            Quarto_is_in_python_chunk = function()
                require("otter.tools.functions").is_otter_language_context("python")
            end

            vim.cmd([[
            let g:slime_dispatch_ipython_pause = 100
            function SlimeOverride_EscapeText_quarto(text)
                call v:lua.Quarto_is_in_python_chunk()
                if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
                    return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
                else
                    if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
                        return [a:text, "\n"]
                else
                    let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
                    let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
                    let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
                    let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
                    let except_pat = '\(elif\|else\|except\|finally\)\@!'
                    let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
                    return substitute(dedented_lines, add_eol_pat, "\n", "g")
                end
            end
            endfunction
            ]])

            vim.g.slime_target = "neovim"
            vim.g.slime_python_ipython = 1
            -- vim.g.slime_bracketed_paste = 1
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
                config = function()
                    local otter = require("otter")
                    otter.setup({
                        lsp = {
                            diagnostics_update_events = { "BuffWritePost" },
                            hover = {
                                border = "single",
                            },
                        },
                        buffers = {
                            set_filetype = true,
                            write_to_disk = false,
                        },
                        strip_wrapping_quote_characters = { "'", '"', "`" },
                        handle_leading_whitespace = true,
                    })
                    local languages = { "python", "markdown", "R", "neorg" }
                    local completion = true
                    local diagnostics = true
                    -- `treesitter` query to look for embedded languages
                    -- uses injections if nil or not set
                    local tsquery = nil

                    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
                        pattern = { "*.ipynb", "*.md", "norg" },
                        desc = "Otter actions",
                        callback = function()
                            local bufnr = vim.api.nvim_get_current_buf()
                            otter.activate(languages, completion, diagnostics, tsquery)
                            vim.keymap.set("n", "gd", function()
                                otter.ask_definition()
                            end, { buffer = bufnr })
                            vim.keymap.set("n", "K", function()
                                otter.ask_hover()
                            end, { buffer = bufnr })
                            vim.keymap.set("n", "gr", function()
                                otter.ask_references()
                            end, { buffer = bufnr })
                            vim.keymap.set("x", "<C-r><C-r>", function()
                                otter.ask_references()
                            end, { buffer = bufnr })
                            vim.keymap.set("x", "<C-r>r", function()
                                otter.ask_references()
                            end, { buffer = bufnr })
                            vim.keymap.set("n", "grn", function()
                                otter.ask_rename()
                            end, { buffer = bufnr })
                        end,
                    })
                end,
            },
        },
    },

    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            {
                'tpope/vim-dadbod',
                lazy = true
            },
            {
                'kristijanhusak/vim-dadbod-completion',
                ft = { 'sql', 'mysql', 'plsql' },
                lazy = true,
            }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            custom_language_formatting = {
                python = {
                    extension = "qmd",
                    style = "quarto",
                    force_ft = "quarto",
                },
                r = {
                    extension = "qmd",
                    style = "quarto",
                    force_ft = "quarto",
                },
            },
        },
    },

    -- Testing
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
})
