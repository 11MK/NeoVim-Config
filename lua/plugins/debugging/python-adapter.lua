---------- PYTHON DEBUG ADAPTER -----------
-- local status_ok, python = pcall(require, "dap-python")
-- if not status_ok then
--   return
-- end
-- python.setup('/home/max/.local/lib/python3.10/site-packages/')

local loaded, dap = pcall(require, "dap")
if not loaded then
  return
end

dap.adapters.debugpy = {
	type = "executable",
	command = '/home/max/.local/share/nvim/mason/packages/debugpy/debugpy-adapter', -- adjust as needed
	name = "debugpy",
}

local debugpy = {
	name = "Launch debugpy",
	type = "debugpy", -- matches the adapter
	request = "launch", -- could also attach to a currently running process
	program = function()
		return vim.fn.input(
			"Path to executable: ",
			vim.fn.getcwd() .. "/",
			"file"
		)
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = {},
	runInTerminal = false,
}

dap.configurations.python = {
	debugpy -- different debuggers or more configurations can be used here
}
