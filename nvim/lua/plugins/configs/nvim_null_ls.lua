local null_ls = require("null-ls")
local util = require("null-ls.utils")

null_ls.setup({
    debug = false,
    tmp_dir = "/tmp",
    sources = {
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.diagnostics.mypy.with({
        --     runtime_condition = function(params)
        --         return utils.path.exists(params.bufname)
        --     end,
        --     cwd = function(_)
        --         return util.root_pattern(".git")(vim.fn.expand("%:p"))
        --     end,
        -- }),
        null_ls.builtins.diagnostics.djlint,
        null_ls.builtins.formatting.djlint,
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.diagnostics.ruff,
        -- null_ls.builtins.formatting.ruff,
        null_ls.builtins.formatting.rustfmt,
        -- null_ls.builtins.diagnostics.sqlfluff.with({
        --     extra_args = {
        --         "--dialect",
        --         "redshift",
        --         "--config",
        --         util.root_pattern(".git")(vim.fn.expand("%:p")) .. "/.sqlfluff",
        --     },
        -- }),
        -- null_ls.builtins.formatting.sqlfluff.with({
        --     extra_args = {
        --         "--dialect",
        --         "redshift",
        --         "--config",
        --         util.root_pattern(".git")(vim.fn.expand("%:p")) .. "/.sqlfluff",
        --     },
        -- }),
    },
})
