local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost init.lua source <afile> | PackerSync
--   augroup end
-- ]])

local plugins = {
	-- TOOL
	"nvim-lua/plenary.nvim", -- Useful lua functions needed by lots of plugins
	"nvim-tree/nvim-tree.lua", -- nvim file explorer
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- event = { "BufReadPost", "BufNewFile" },
	}, -- syntax highlighting
	"nvim-telescope/telescope.nvim", -- tag = "0.1.1", -- folder searcher
	"folke/flash.nvim", -- quick code navigation
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	--  MARKDOWN --
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
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

			-- see below for full list of options 👇
		},
	},

	-- COMPLETION --
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp", -- lsp completion
	"hrsh7th/cmp-nvim-lua", -- lua completion

	-- SNIPPETS --
	{ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }, --snippet engine
	{ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }, -- a bunch of snippets to use

	-- LSP
	"williamboman/mason.nvim", -- simple to use language server installer
  "neovim/nvim-lspconfig", -- enable LSP
	"williamboman/mason-lspconfig.nvim", --
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	"RRethy/vim-illuminate", -- same word highlighting
	"simrat39/rust-tools.nvim",
	"mfussenegger/nvim-jdtls", -- Java shit

	-- STATUSLINE, TABS, UI
	"rebelot/heirline.nvim",
	{ "akinsho/bufferline.nvim", dependencies = "nvim-tree/nvim-web-devicons" }, -- bufer tabs
	"nvim-tree/nvim-web-devicons", -- nvim tree icons,
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- DATABASES
	"kristijanhusak/vim-dadbod-ui",
	"kristijanhusak/vim-dadbod-completion",
	{
		"tpope/vim-dadbod",
		opt = true,
		requires = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			require("plugins.dadbod")
		end,
	},

	-- DEBUGGING

	"theHamsta/nvim-dap-virtual-text",

	"nvim-telescope/telescope-dap.nvim",
	"jbyuki/one-small-step-for-vimkind",
	{
		"mfussenegger/nvim-dap",
		opt = false,
		-- event = "BufReadPre",
		wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python" },
		dependencies = { "theHamsta/nvim-dap-virtual-text", "nvim-telescope/telescope-dap.nvim" },
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

	-- HANDY PLUGINS
	"windwp/nvim-autopairs", -- auto-generate pairs for chars
	"numToStr/Comment.nvim", -- smart and powerful comments
	"norcalli/nvim-colorizer.lua", -- colorizer
	"lukas-reineke/indent-blankline.nvim", -- verticle indentlines
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"kylechui/nvim-surround", -- edit surrounding characters
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- COLORSCHEMES
	{ "navarasu/onedark.nvim", as = "onedark" },
	{ "11MK/yami.nvim", as = "yami" },
	"rmehri01/onenord.nvim",
	{
		"neanias/everforest-nvim",
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup()
		end,
	},
	"folke/tokyonight.nvim",
	{ "catppuccin/nvim", as = "catppuccin" },
}

local opts = {}

require("lazy").setup(plugins, opts)
