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
	return { noremap = true, silent = true, desc = description }
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
-- keymap("n", "<leader>x", "<cmd> w <CR> <cmd> bp<bar>sp<bar>bn<bar>bd <CR>", opts("delete buffer"))
keymap("n", "<leader>x", "<cmd> bp<bar>sp<bar>bn<bar>bd <CR>", opts("delete buffer"))
-- keymap("n", "<leader>ll", "<cmd> :luafile % <CR>", opts("delete buffer"))



keymap("n", "<A-C-k>", "<cmd>  <CR>", opts("up 3 and center")) -- "Universal" split. Opposide of <K> "join"
keymap("n", "<A-k>", "3k zz", opts("up 3 and center"))
keymap("n", "<A-j>", "3j zz", opts("down 3 and center"))

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
keymap("n", "<leader>ff", "<cmd>Telescope find_files <CR>", opts("telescope find files"))
keymap("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", opts("telescope help"))
keymap("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", opts("telescope find oldfiles"))
keymap(
	"n",
	"<leader>fa",
	"<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
	opts("telescope find all")
)
keymap("n", "<leader>tk", "<cmd> Telescope keymaps <CR>", opts("telescope show keymaps"))
keymap("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", opts("telescope git commits"))
keymap("n", "<leader>gs", "<cmd> Telescope git_status <CR>", opts("telescope git status"))

-------------- COMMENT ---------------
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts("toggle comment"))
keymap(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	opts("toggle comment")
)
----------- NVIM-SURROUND -----------

------------- NVIM-TREE ---------------
keymap("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", opts("nvim-tree toggle"))

------------ BUFFERLINE ---------------
keymap("n", "<tab>", "<cmd> :BufferLineCycleNext<CR>", opts("next buffer"))
keymap("n", "<S-tab>", "<cmd> :BufferLineCyclePrev<CR>", opts("previous buffer"))
keymap("n", "<leader>x", "<cmd> :bdelete <CR> ", opts("close current buffer"))

------------ DAP ---------------
keymap("n", "<leader>dR", "<cmd> lua require('dap').run_to_cursor() <CR> ", opts("dap run to cursor"))
keymap(
	"n",
	"<leader>dE",
	"<cmd> lua require('dapui').eval(vim.fn.input '[expression] > ') <CR> ",
	opts("dap evaluate input")
)
keymap(
	"n",
	"<leader>dC",
	"<cmd> lua require('dap').set_breakpoint(vim.fn.input '[condition] > ') <CR> ",
	opts("dap conditional breakpoint")
)
keymap("n", "<leader>dU", "<cmd> NvimTreeClose <CR> <cmd> lua require('dapui').toggle() <CR> ", opts("dap toggle ui"))
keymap("n", "<leader>db", "<cmd> lua require('dap').step_back() <CR> ", opts("dap step back"))
keymap("n", "<leader>dc", "<cmd> lua require('dap').continue() <CR> ", opts("dap continue"))
keymap("n", "<leader>dd", "<cmd> lua require('dap').disconnect() <CR> ", opts("dap disconnect"))
keymap("n", "<leader>de", "<cmd> lua require('dapui').eval() <CR> ", opts("dap evaluate"))
keymap("v", "<leader>de", "<cmd> lua require('dapui').eval() <CR> ", opts("dap evaluate"))
keymap("n", "<leader>dg", "<cmd> lua require('dap').session() <CR> ", opts("dap get session"))
keymap("n", "<leader>dh", "<cmd> lua require('dap.ui.widgets').hover() <CR> ", opts("dap hover variables"))
keymap("n", "<leader>dS", "<cmd> lua require('dap.ui.widgets').scopes() <CR> ", opts("dap scopes"))
keymap("n", "<leader>di", "<cmd> lua require('dap').step_into() <CR> ", opts("dap step into"))
keymap("n", "<leader>do", "<cmd> lua require('dap').step_over() <CR> ", opts("dap step over"))
keymap("n", "<leader>du", "<cmd> lua require('dap').step_out() <CR> ", opts("dap step out"))
keymap("n", "<leader>dp", "<cmd> lua require('dap').pause.toggle() <CR> ", opts("dap pause"))
keymap("n", "<leader>dq", "<cmd> lua require('dap').close() <CR> ", opts("dap quit"))
keymap("n", "<leader>dr", "<cmd> lua require('dap').repl.toggle() <CR> ", opts("dap toggle repl"))
keymap("n", "<leader>ds", "<cmd> lua require('dap').continue() <CR> ", opts("dap start"))
keymap("n", "<leader>dt", "<cmd> lua require('dap').toggle_breakpoint() <CR> ", opts("dap toggle breakpoint"))
keymap("n", "<leader>dx", "<cmd> lua require('dap').terminate() <CR> ", opts("dap terminate"))
