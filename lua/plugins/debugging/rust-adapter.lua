---------- RUST DEBUG ADAPTER -----------
local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
  return
end

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

-- Rust LSP
local opts = {
  -- rust-tools options
  tools = {
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  hover_actions = {
    -- whether the hover action window gets automatically focused
    -- default: false
    -- the border that is used for the hover window
    -- see vim.api.nvim_open_win()
    border = {
      { "┌", "FloatBorder" },
      { "─", "FloatBorder" },
      { "┐", "FloatBorder" },
      { "│", "FloatBorder" },
      { "┘", "FloatBorder" },
      { "─", "FloatBorder" },
      { "└", "FloatBorder" },
      { "│", "FloatBorder" },
    },
    auto_focus = true,
  },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  -- https://rust-analyzer.github.io/manual.html#features
  server = {
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate",
        },
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy",
        },
      },
      inlayHints = {
        lifetimeElisionHints = {
          enable = true,
          useParameterNames = true,
        },
      },
    },
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { buffer = bufnr })
      vim.keymap.set("n", "<Leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}
-- print(require("rust-tools.dap").get_codelldb_adapter(codelldb_path))

rt.setup(opts)

local loaded, dap = pcall(require, "dap")
if not loaded then
  return
end

dap.adapters.lldb = {
  type = "executable",
  command = liblldb_path, -- adjust as needed
  name = "lldb",
}

local lldb = {
  name = "Launch lldb",
  type = "lldb",     -- matches the adapter
  request = "launch", -- could also attach to a currently running process
  -- program = function()
  -- 	return vim.fn.input(
  -- 		"Path to executable: ",
  -- 		vim.fn.getcwd() .. "/",
  -- 		"file"
  -- 	)
  -- end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
  runInTerminal = false,
}

dap.configurations.rust = {
  lldb, -- different debuggers or more configurations can be used here
}
