local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- TOOLS
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions needed by lots of plugins
	use({ "nvim-tree/nvim-tree.lua" }) -- nvim file explorer
	use({ "nvim-treesitter/nvim-treesitter" }) -- syntax highlighting
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.1" }) -- folder searcher
	use({
		"zbirenbaum/copilot.lua",
    cmd = "Copilot",
		event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
	})
	-- COMPLETIONS --
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" }) -- lsp completion
	use({ "hrsh7th/cmp-nvim-lua" }) -- lua completion
	-- SNIPPETS --
	use({ "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" }) -- a bunch of snippets to use
	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/mason.nvim" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim" }) --
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" }) -- same word highlighting
	use({ "simrat39/rust-tools.nvim" })
	-- STATUSLINE, TABS, UI
	use({ "rebelot/heirline.nvim" })
	use({ "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons" }) -- bufer tabs
	use({ "nvim-tree/nvim-web-devicons" }) -- nvim tree icons
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	-- DEBUGGING
	use({
		"theHamsta/nvim-dap-virtual-text",
	})
	use({ "nvim-telescope/telescope-dap.nvim" })
	use({ "jbyuki/one-small-step-for-vimkind" })
	use({
		"mfussenegger/nvim-dap",
		opt = false,
		-- event = "BufReadPre",
		wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python" },
		requires = { "theHamsta/nvim-dap-virtual-text", "nvim-telescope/telescope-dap.nvim" },
	})
	-- use({ "mfussenegger/nvim-dap-python" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	-- HANDY PLUGINS
	use({ "windwp/nvim-autopairs" }) -- auto-generate pairs for chars
	use({ "numToStr/Comment.nvim" }) -- smart and powerful comments
	use({ "norcalli/nvim-colorizer.lua" }) -- colorizer
	use({ "lukas-reineke/indent-blankline.nvim" }) -- verticle indentlines
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
	use({
		"kylechui/nvim-surround", -- edit surrounding characters
		tag = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	})
	-- COLORSCHEMES
	use({ "navarasu/onedark.nvim", as = "onedark" })
	use("rmehri01/onenord.nvim")
	use({
		"neanias/everforest-nvim",
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup()
		end,
	})
	use({
		"folke/tokyonight.nvim",
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
