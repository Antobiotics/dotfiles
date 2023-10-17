local vim = vim
vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
                .nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match("%s")
            == nil
end

-- nvim-cmp setup
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            -- load lspkind icons
            vim_item.kind = string.format(
                "%s %s",
                require("plugins.configs.lspkind_icons").icons[vim_item.kind],
                vim_item.kind
            )

            vim_item.menu = ({
                otter = "[🦦]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                buffer = "[BUF]",
                path = "[PATH]",
                luasnip = "[snip]",
                fzy_buffer = "[fzbuf]",
                fuzzy_path = "[fzpath]",
                cmdline = "[cmd]",
                cmdline_history = "[cmd-hist]",
                emoji = "[emoji]",
            })[entry.source.name]

            vim_item.dup = ({
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
            })[entry.source.name] or 0

            return vim_item
        end,
    },
    mapping = {
        ["<Down>"] = cmp.mapping(
            cmp.mapping.select_next_item({
                behavior = cmp.SelectBehavior.Select,
            }),
            { "i" }
        ),
        ["<Up>"] = cmp.mapping(
            cmp.mapping.select_prev_item({
                behavior = cmp.SelectBehavior.Select,
            }),
            { "i" }
        ),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-c>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     local luasnip = require("luasnip")
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     local luasnip = require("luasnip")
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
    },
    sources = {
        { name = "copilot" },
        { name = "otter" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    local LIMIT = 1024 * 512 -- 512 kb max
                    local bufs = {}

                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        local line_count = vim.api.nvim_buf_line_count(buf)
                        local byte_size =
                            vim.api.nvim_buf_get_offset(buf, line_count)

                        if byte_size < LIMIT then
                            bufs[buf] = true
                        end
                    end

                    return vim.tbl_keys(bufs)
                end,
            },
        },
        { name = "nvim_lua" },
        {
            name = "path",
            option = {
                trailing_slash = true,
            },
        },
        -- { name = "fzy_buffer" },
        -- { name = 'fuzzy_path' },
        { name = "emoji" },
    },
    experimental = {
        ghost_text = true,
    },
})

-- Use cmdline & path source for ':'.
for _, cmd_type in ipairs({ ":", "/", "?", "@", "=" }) do
    cmp.setup.cmdline(cmd_type, {
        sources = {
            { name = "cmdline" },
            { name = "path" },
            -- { name = "fzy_buffer" },
            -- { name = 'fuzzy_path' },
            { name = "cmdline_history" },
        },
    })
end

cmp.event:on("menu_opened", function()
    vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
    vim.b.copilot_suggestion_hidden = false
end)
-- require("luasnip.loaders.from_vscode").lazy_load()
