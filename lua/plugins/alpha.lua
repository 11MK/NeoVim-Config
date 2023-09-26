local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local ok, art = pcall(require, "utils.ascii-art")
if not ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

local function button(sc, txt, keybind, keybind_opts)
	local b = dashboard.button(sc, txt, keybind, keybind_opts)
	b.opts.hl_shortcut = "Macro"
	return b
end

dashboard.section.header.val = art.nerv

dashboard.section.buttons.val = {
	button("f", "" .. " Find file", ":Telescope find_files <CR>"),
	button("e", "" .. " New file", ":ene <BAR> startinsert <CR>"),
	-- button("p", "" .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
	button("r", "" .. " Recent files", ":Telescope oldfiles <CR>"),
	button("t", "" .. " Find text", ":Telescope live_grep <CR>"),
	button("h", "󱩾" .. " Help files", ":Telescope help_tags <CR>"),
	-- dashboard.button("s", icons.ui.SignIn .. " Find Session", ":silent Autosession search <CR>"),
	button("s", "" .. " Find Session", ":SearchSession<CR>"),
	button("c", "" .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
	button("u", "" .. " Update", ":PackerSync<CR>"),
	button("q", "" .. " Quit", ":qa<CR>"),
}

local function footer()
	-- Number of plugins
	local datetime = os.date("%d-%m-%Y %H:%M:%S")
	local plugins_text = "  "
		.. #vim.tbl_keys(require("lazy").plugins())
		.. " plugins"
		.. "    "
		.. vim.version().major
		.. "."
		.. vim.version().minor
		.. "."
		.. vim.version().patch
		.. "    "
		.. datetime
	return plugins_text
end
-- local function footer()
-- 	-- NOTE: requires the fortune-mod package to work
-- 	-- local handle = io.popen("fortune")
-- 	-- local fortune = handle:read("*a")
-- 	-- handle:close()
-- 	-- return fortune
-- 	return "chrisatmachine.com"
-- end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "Comment"
dashboard.section.buttons.opts.hl = "Macro"
dashboard.section.footer.opts.hl = "Comment"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
