local null_ls = require("null-ls")
local utils = require("null-ls.utils")
local helpers = require("null-ls.helpers")

local get_poetry_virtual_env_bin_path = function(dir)
    local virtual_env_path = vim.fn.trim(vim.fn.system("poetry -C " .. dir .. " env info -p"))
    local bin_path = virtual_env_path .. "/bin"
    return bin_path
end

local get_poetry_bin_cmd_path = function(cmd, pattern)
    pattern = pattern or "pyproject.toml"
    return function(opts)
        local buf_workspace_dir = helpers.cache.by_bufnr(function(params)
            return utils.root_pattern(pattern)(params.bufname)
        end)(opts)

        local virtual_env_path = get_poetry_virtual_env_bin_path(buf_workspace_dir)
        return virtual_env_path .. "/" .. cmd
    end
end

null_ls.setup({
    debug = false,
    tmp_dir = "/tmp",
    sources = {
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.diagnostics.mypy.with({
        --     dynamic_command = get_poetry_bin_cmd_path("mypy", ".git"),
        -- }),
        -- null_ls.builtins.diagnostics.pylint.with({
        -- dynamic_command = get_poetry_bin_cmd_path("pylint"),
        -- }),
        null_ls.builtins.diagnostics.djlint,
        null_ls.builtins.formatting.djlint,
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.diagnostics.ruff,
        -- null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.ruff.with({
            dynamic_command = get_poetry_bin_cmd_path("ruff"),
        }),
        null_ls.builtins.formatting.ruff.with({
            dynamic_command = get_poetry_bin_cmd_path("ruff"),
        }),
        -- null_ls.builtins.formatting.ruff,
        -- null_ls.builtins.formatting.rustfmt,
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
