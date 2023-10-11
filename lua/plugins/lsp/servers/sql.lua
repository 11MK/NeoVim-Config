return {
	settings = {
		cmd = { "/usr/bin/sqlite3", "up", "--method", "stdio" },
		filetypes = { "sql", "mysql" },
		root_dir = function()
			return vim.loop.cwd()
		end,
	},
}
