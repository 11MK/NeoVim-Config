-- ───────────────────────────────────
--    [ K | E | Y | M | A | P | S ]
-- ───────────────────────────────────
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local function opts(description)
	-- function body (a function's body is the code it contains)
  return { noremap = true, silent = true, desc=description }
end

local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- ───────────────────────────────────
--              GENERAL
-- ───────────────────────────────────
keymap("", "<Space>", "<Nop>", opts("remap space"))
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------- NORMAL ---------------
keymap("n", "<C-h>", "<C-w>h", opts("window left"))
keymap("n", "<C-l>", "<C-w>l", opts("window right"))
keymap("n", "<C-j>", "<C-w>j", opts("window up"))
keymap("n", "<C-k>", "<C-w>k", opts("window down"))

keymap("n", "<leader>w", "<cmd> w <CR>", opts("save file"))

-------------- INSERT ---------------
keymap("i", "jk", "<ESC>", opts("better escape"))
keymap("i", "kj", "<ESC>", opts("better escape"))

keymap("i", "<C-h>", "<Left>", opts("move left"))
keymap("i", "<C-l>", "<Right>", opts("move right"))
keymap("i", "<C-j>", "<Down>", opts("move down"))
keymap("i", "<C-k>", "<Up>", opts("move up"))

-------------- VISUAL ---------------
keymap("v", "<", "<gv", opts("indent backward and stay in visual mode"))
keymap("v", ">", ">gv", opts("indent forward and stay in visual mode"))


keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts("move text up"))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts("move text down"))

-- ───────────────────────────────────
--             PLUGINS
-- ───────────────────────────────────
--
------------- TELESCOPE ---------------
keymap("n", "<leader>ff",  "<cmd>Telescope find_files <CR>", opts("telescope find files"))
keymap("n", "<leader>fh",  "<cmd> Telescope help_tags <CR>", opts("telescope help"))
keymap("n", "<leader>fo",  "<cmd> Telescope oldfiles <CR>", opts("telescope find oldfiles"))
keymap("n", "<leader>fa",  "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", opts("telescope find all"))
keymap("n", "<leader>tk",  "<cmd> Telescope keymaps <CR>", opts("telescope show keymaps"))
keymap("n", "<leader>gc",  "<cmd> Telescope git_commits <CR>", opts("telescope git commits"))
keymap("n", "<leader>gs",  "<cmd> Telescope git_status <CR>", opts("telescope git status"))

-------------- COMMENT ---------------
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts("toggle comment"))
keymap("v", "<leader>/",  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts("toggle comment"))

------------- NVIM-TREE ---------------
keymap("n", "<C-n>",  "<cmd> NvimTreeToggle <CR>", opts("nvim-tree toggle"))


------------ BUFFERLINE ---------------
keymap("n", "<tab>",  "<cmd> :BufferLineCycleNext<CR>", opts("next buffer"))
keymap("n", "<S-tab>",  "<cmd> :BufferLineCyclePrev<CR>", opts("previous buffer"))
keymap("n", "<leader>x",  "<cmd> :bdelete <CR> ", opts("close current buffer"))


