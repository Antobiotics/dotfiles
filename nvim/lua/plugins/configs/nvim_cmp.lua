local vim = vim
vim.opt.completeopt = "menuone,noselect"

local cmp = require("cmp")

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
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        buffer = "[BUF]",
        path = "[PATH]",
        luasnip = "[snip]",
        fzy_buffer = "[fzbuf]",
        fuzzy_path = "[fzpath]",
        cmdline = "[cmd]",
        cmdline_history = "[cmd-hist]",
        emoji = "[emoji]"
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
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
          "n"
        )
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>luasnip-expand-or-jump",
            true,
            true,
            true
          ),
          ""
        )
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
          "n"
        )
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(
            "<Plug>luasnip-jump-prev",
            true,
            true,
            true
          ),
          ""
        )
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    -- { name = "path" },
    { name = 'fuzzy_path' },
    { name = 'fzy_buffer' },
    { name = 'fuzzy_path' },
    { name = 'emoji' },
  },
  experimental = {
    ghost_text = true
  },
})

-- Use cmdline & path source for ':'.
for _, cmd_type in ipairs({':', '/', '?', '@', '='}) do
    cmp.setup.cmdline(cmd_type, {
        sources = {
            { name = 'cmdline' },
            { name = 'fzy_buffer' },
            -- { name = 'path' },
            { name = 'fuzzy_path' },
            { name = 'cmdline_history' },
        }
    })
end
