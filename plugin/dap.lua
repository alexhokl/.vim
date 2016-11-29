-- note that installing codelldb, netcoredbg and debugpy is required
-- it can be done with mason

local dap, dapui = require("dap"), require("dapui")
local vscode = require('dap.ext.vscode')
-- local mason_registry = require("mason-registry")

local defaultKeymapOpts = {
	noremap = true,
	silent = true
}

local virtual_text = require("nvim-dap-virtual-text")
virtual_text.setup()

local go = require("dap-go")
go.setup()

local dotnet = require("dap-dotnet")
dotnet.setup()

local python = require("dap-python")

local package_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
local codelldb_path = package_path .. "codelldb/extension/adapter/codelldb"
-- local netcoredbg_path = "/usr/local/netcoredbg"
local debugpy_path = package_path .. "debugpy/venv/bin/python"
local flutter_path = os.getenv("HOME") .. "/git/flutter/bin/flutter"

-- potentially breaks tree-sitter for python
-- reference: https://github.com/mfussenegger/nvim-dap-python#tree-sitter
python.setup(debugpy_path)

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" },
	}
}

-- dap.adapters.coreclr = {
-- 	type = 'executable',
-- 	command = netcoredbg_path,
-- 	args = { '--interpreter=vscode' },
-- }

dap.adapters.dart = {
	type = 'executable',
	command = flutter_path,
	args = { 'debug_adapter' },
	-- toolArgs = { '--device-id', 'chrome' },
}

vscode.load_launchjs(nil, {
	coreclr = { "cs" },
	dart = { "dart" },
	codelldb = { "rust", "c", "cpp" },
})

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set("n", "<F9>", ':DapToggleBreakpoint<CR>', defaultKeymapOpts)
vim.keymap.set("n", "<F10>", ':DapStepOver<CR>', defaultKeymapOpts)
vim.keymap.set("n", "<F11>", ':DapStepInto<CR>', defaultKeymapOpts)
vim.keymap.set("n", "<F12>", ':DapStepOut<CR>', defaultKeymapOpts)
vim.keymap.set("n", "<F5>", ':DapContinue<CR>', defaultKeymapOpts)
--
-- if vim.bo.filetype == "dart" then
-- 	vim.keymap.set("n", "<F5>", ':FlutterRun<CR>', defaultKeymapOpts)
-- else
-- 	vim.keymap.set("n", "<F5>", ':DapContinue<CR>', defaultKeymapOpts)
-- end

