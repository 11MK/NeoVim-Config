local opts = {
	workspaces = {
		{
			name = "brain",
			path = "~/vaults/brain",
		},
		{
			name = "work",
			path = "~/vaults/work",
		},
	},
	mappings = {
		-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		-- Toggle check-boxes.
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
	},
	wiki_link_func = function(opts)
		if opts.id == nil then
			return string.format("[[%s]]", opts.label)
		elseif opts.label ~= opts.id then
			return string.format("[[li|%s]]", opts.label)
		else
			return string.format("[[%s]]", opts.id)
		end
	end,
	-- see below for full list of options 👇
}
