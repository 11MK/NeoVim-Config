local overrides = require "custom.plugins.overrides"

return {

  ["goolord/alpha-nvim"] = { disable = false },

  ["simrat39/rust-tools.nvim"] = {
    after = "nvim-lspconfig",
    config = function ()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end
  },

  ["ggandor/leap.nvim"] = {
    config = function()
      require("leap").set_default_keymaps()
    end
  },

  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.lspconfig"
      end,
  },

  -- overrde plugin configs
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  -- ["rcarriga/nvim-dap-ui"] = {
  --   config = function()
  --     require("nvim-dap")
  --   end
  -- },

  ["mfussenegger/nvim-dap"] = {
    config = function()
      local dap = require("dap")
      dap.adapters.python = {
        type = 'executable';
        command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
        args = { '-m', 'debugpy.adapter' };
      }
      dap.configurations.python = {
        {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return '/usr/bin/python'
        end,
        },
      }
    end,
  },
  --
  -- ["rcarriga/nvim-dap-ui"] = {
  --     after = "nvim-dap",
  --     config = function()
  --       require("nvim-dap")
  --     end,
  -- },
  --
  -- ["kyazdani42/nvim-tree.lua"] = {
  --   override_options = overrides.nvimtree,
  -- },
  -- Install a plugin
  -- ["max397574/better-escape.nvim"] = {
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  -- code formatting, linting etc
  -- ["jose-elias-alvarez/null-ls.nvim"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require "custom.plugins.null-ls"
  --   end,
  -- },

  -- remove plugin
  -- ["hrsh7th/cmp-path"] = false,
}
