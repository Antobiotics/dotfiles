local null_ls = require("null-ls")
local util = require("null-ls.utils")

null_ls.setup({
    debug = false,
    tmp_dir = "/tmp",
    sources = {
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.djlint,
        null_ls.builtins.formatting.djlint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.rustfmt,
    },
})
