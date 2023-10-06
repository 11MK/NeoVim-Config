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
  "nvim-treesitter/nvim-treesitter", -- syntax highlighting
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

  -- COMPLETION --
  "hrsh7th/nvim-cmp" , -- The completion plugin
  "hrsh7th/cmp-buffer" , -- buffer completions
  "hrsh7th/cmp-path" , -- path completions
  "saadparwaiz1/cmp_luasnip" , -- snippet completions
  "hrsh7th/cmp-nvim-lsp" , -- lsp completion
  "hrsh7th/cmp-nvim-lua" , -- lua completion

  -- SNIPPETS --
  {"L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84"}, --snippet engine
  {"rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1"}, -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim", -- simple to use language server installer
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
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',
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
  "rmehri01/onenord.nvim",
  {
    "neanias/everforest-nvim",
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup()
    end,
  },
  "folke/tokyonight.nvim",
  {"catppuccin/nvim", as = "catppuccin"},
}

local opts = {}

require("lazy").setup(plugins, opts)
