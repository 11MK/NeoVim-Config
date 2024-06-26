vim.o.termguicolors = true
-- [[ COLORSCHEME OneDark ]]
-- require("onedark").setup({
-- 	style = "darker",
-- })
-- require("onedark").load()

-- [[ COLORSCHEME Yami ]]
-- require("yami").setup({
-- 	highlights = {
-- 		black = "#24272D",
-- 		-- bg0 = "#25282e",  -- Darker
--     -- bg0 = "#122932",
-- 		bg0 = "#2a2d34", -- Ligher
-- 		bg1 = "#3F444C",
-- 		bg2 = "#515760",
-- 		bg3 = "#646A74",
-- 		bg_d = "#25282e",
-- 		bg_blue = "#61afef",
-- 		fg = "#C6C6C0",
-- 		purple = "#E4DAC3", -- #E4DAC3 #FED897
-- 		green = "#95C561",
-- 		-- orange = "#dae0b8",#7ACC8F
-- 		orange = "#aad6a4",
-- 		blue = "#C6DDF0",
-- 		yellow = "#C5F4E0",
-- 		cyan = "#e5c185",
-- 		red = "#df9290",
-- 		grey = "#535965",
-- 		tan = "#c0c0ae",
-- 		-- tan = "#c5ccc1",
--     brown = "#AD957B",
-- 		light_grey = "#7a818e",
-- 		light_tan = "#c5ccc1",
-- 		dark_cyan = "#266269",
-- 		dark_red = "#8b3434",
-- 		dark_yellow = "#835d1a",
-- 		dark_purple = "#7e3992",
-- 		diff_add = "#272e23",
-- 		diff_delete = "#2d2223",
-- 		diff_change = "#172a3a",
-- 		diff_text = "#274964",
--
--
-- bg0 = "#25282e",  -- Darker
-- bg0 = "#122932",
-- black = "#1E1E2E", -- old bg
-- 		bg0 = "#1E1E2E", -- Ligher
-- 		bg1 = "#2E2E43",
-- 		bg2 = "#3F3F58",
-- 		bg3 = "#52526D",
-- 		bg_d = "#191926",
-- 		bg_blue = "#61afef",
-- 		fg = "#E2E2EA",
-- 		-- purple = "#bc74de", --original
-- 		-- purple = "#d6b0eb",
-- 		purple = "#ca92e5", -- mixed
-- 		green = "#aae7b2",
-- 		-- orange = "#e9ae5a", -- original
-- 		-- orange = "#f8bd96",
--     orange = "#f0b578", -- mixed
-- 		-- blue = "#5dbce7", -- original
-- 		-- blue = "#96cdfb",
--     blue = "#7cc5f1", -- mixed
-- 		yellow = "#ebd36a",
-- 		cyan = "#88dbca",
-- 		-- red = "#f4877c",  -- original
-- 		-- red = "#f28fad",
--     red = "#f38a93", --mixed
-- 		grey = "#535965",
-- 		-- tan = "#c0c0ae",
-- 		tan = "#c5ccc1",
--     brown = "#636940",
-- 		light_grey = "#7a818e",
-- 		light_tan = "#c5ccc1",
-- 		dark_cyan = "#266269",
-- 		dark_red = "#8b3434",
-- 		dark_yellow = "#835d1a",
-- 		dark_purple = "#7e3992",
-- 		diff_add = "#272e23",
-- 		diff_delete = "#2d2223",
-- 		diff_change = "#172a3a",
-- 		diff_text = "#274964",
-- 	},
-- })
-- require("yami").load()

-- [[ COLORSCHEME OneNord ]]
-- require("onenord").setup()

-- [[ COLORSCHEME TokyoNight ]]
-- require("tokyonight").setup({
-- 	-- your configuration comes here
-- 	-- or leave it empty to use the default settings
-- 	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
-- 	light_style = "day", -- The theme is used when the background is set to light
-- 	transparent = false, -- Enable this to disable setting the background color
-- 	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
-- 	styles = {
-- 		-- Style to be applied to different syntax groups
-- 		-- Value is any valid attr-list value for `:help nvim_set_hl`
-- 		comments = { italic = true },
-- 		keywords = { italic = false },
-- 		functions = {},
-- 		variables = {},
-- 		-- Background styles. Can be "dark", "transparent" or "normal"
-- 		sidebars = "dark", -- style for sidebars, see below
-- 		floats = "dark", -- style for floating windows
-- 	},
-- 	sidebars = { "packer", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
-- 	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
-- 	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
-- 	dim_inactive = false, -- dims inactive windows
-- 	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
--
-- 	--- You can override specific color groups to use other groups or a hex color
-- 	--- function will be called with a ColorScheme table
-- 	---@param colors ColorScheme
-- 	on_colors = function(colors) end,
--
-- 	--- You can override specific highlights to use other groups or a hex color
-- 	--- function will be called with a Highlights and ColorScheme table
-- 	---@param highlights Highlights
-- 	---@param colors ColorScheme
-- 	on_highlights = function(highlights, colors) end,
-- })
-- require("tokyonight").load()

-- [[ COLORSCHEME Catppuccin ]]
require("catppuccin").setup({
	flavour = "frappe", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = false,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin-mocha")
