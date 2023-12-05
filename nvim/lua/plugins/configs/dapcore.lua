local vim = vim
local dap = require("dap")
local ui = require("dapui")

local venv = os.getenv("VIRTUAL_ENV")
local python_path = string.format("%s/bin/python", venv)

require("nvim-dap-virtual-text").setup({
  highlight_changed_variables = true,
})
require("dap-python").setup(python_path)
require("dap-python").test_runner = "pytest"

dap.adapters.python = {
  type = "executable",
  command = python_path,
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = python_path,
    console = "integratedTerminal",
  },
  {
    name = "Python attach",
    type = "python",
    request = "attach",
    connect = {
      host = "127.0.0.1",
      port = 5678,
    },
  },
}

local wk = require("plugins.configs.utils").wk

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "B", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" }
)

wk.register({
  ["<leader>dS"] = {
    "<cmd>lua require('dap-python').setup('.venv/bin/path')<cr>",
    "python debug",
  },
})
wk.register({ ["<leader>ds"] = { name = "debug" } })
wk.register({ ["<leader>db"] = { name = "breakpoints" } })

wk.register({
  ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "continue" },
})
wk.register({
  ["<leader>d."] = {
    "<cmd>lua require'dap'.run_to_cursor()<cr>",
    "run to cursor",
  },
})
wk.register({
  ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "step back" },
})
wk.register({
  ["<leader>ds"] = { "<cmd>lua require'dap'.step_over()<cr>", "step over" },
})
wk.register({
  ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "step into" },
})
wk.register({
  ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "step out" },
})
wk.register({
  ["<leader>dp"] = { "<cmd>lua require'dap'.pause.toggle()<cr>", "pause" },
})
wk.register({
  ["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "quit" },
})
wk.register({
  ["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "repl" },
})
wk.register({
  ["<leader>dl"] = { "<cmd>lua require'dap'.run.last()<cr>", "repl" },
})
wk.register({
  ["<leader>dv"] = {
    "<cmd>lua require('dap.ui.variables').hover()<cr>",
    "variables",
  },
})

wk.register({
  ["<leader>dt"] = {
    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    "toggle",
  },
})
wk.register({
  ["<leader>dd"] = {
    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    "toggle",
  },
})
-- wk.register({["<leader>dbb"] = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'toggle'}})
wk.register({
  ["<leader>dC"] = {
    "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    "condition",
  },
})
wk.register({
  ["<leader>dL"] = {
    "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
    "log message",
  },
})

dap.listeners.after["event_initialized"]["dapui_config"] = function()
  ui.open({})
end

dap.listeners.before["event_terminated"]["dapui_config"] = function()
  ui.close({})
end

dap.listeners.before["event_exited"]["dapui_config"] = function()
  ui.close({})
end
