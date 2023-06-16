local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
-- local devicons = require('nvim-web-devicons')


local Align = { provider = "%=" }
local Space = { provider = " " }

local function setup_colors()
  return {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    background = utils.get_highlight("Visual").bg,
    white = utils.get_highlight("@text").fg,
    light_grey = utils.get_highlight("CursorLineNr").bg,
    grey = utils.get_highlight("TabLineFill").fg,
    dark_grey = utils.get_highlight("StatusLineNC").bg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    orange = utils.get_highlight("Float").fg,
    yellow = utils.get_highlight("WarningMsg").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("GitSignsDelete").fg,
    git_add = utils.get_highlight("GitSignsAdd").fg,
    git_change = utils.get_highlight("GitSignsChange").fg,
  }
end

-- require("heirline").load_colors(setup_colors)
-- or pass it to config.opts.colors

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    utils.on_colorscheme(setup_colors)
  end,
  group = "Heirline",
})

local RightEdge = {
  provider = '🭝',
  hl = { fg = "dark_grey", bg = "background" },
}

local RightTri = {
  provider = '🭢',
  hl = { bg = "grey", fg = "dark_grey" },
}

local LeftCap = {
  provider = '█',
  -- provider = '',
  hl = { fg = "dark_grey" },
}

local ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1)     -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = {
                       -- change the strings if you like it vvvvverbose!
      n = "NORMAL",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "VISUAL",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "INSERT",
      ic = "Ic",
      ix = "Ix",
      R = "REPLACE",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "CLEAR",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "TERMINAL",
    },
    mode_colors = {
      n = "red",
      i = "green",
      v = "orange",
      V = "orange",
      ["\22"] = "orange",
      c = "orange",
      s = "purple",
      S = "purple",
      ["\19"] = "purple",
      R = "orange",
      r = "orange",
      ["!"] = "red",
      t = "red",
    }
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  {
    provider = " ",
    hl = function(self)
      local mode = self.mode:sub(1, 1)     -- get only the first mode character
      return { fg = self.mode_colors[mode], bg = "dark_grey" }
    end,
  },
  {
    provider = "🭌",
    hl = function(self)
      local mode = self.mode:sub(1, 1)     -- get only the first mode character
      return { bold = true, bg = self.mode_colors[mode], fg = "dark_grey" }
    end,
  },
  {
    provider = function(self)
      return " " .. self.mode_names[self.mode]
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1)     -- get only the first mode character
      return { bold = true, bg = self.mode_colors[mode], fg = "dark_grey", }
    end,
  },
  {
    provider = function()
      return "%(🭌%)"
    end,

    hl = function(self)
      local mode = self.mode:sub(1, 1)     -- get only the first mode character
      return { fg = self.mode_colors[mode], bg = "dark_grey" }
    end,
  },
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  -- Re-evaluate the component only on ModeChanged event!
  -- Also allows the statusline to be re-evaluated when entering operator-pending mode
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
}

local FileNameBlock = {
  -- let's first set up some attributes needed by this component and it's children
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}
-- We can now define some children separately and add them later


local ParentDirectory = {
  init = function(self)
    local currentFile = vim.fn.expand('%:p')
    self.parentDirectory = vim.fn.fnamemodify(currentFile, ':h:t')
  end,
  provider = function(self)
    return "  " .. self.parentDirectory .. " "
  end,
  hl = { fg = "gray", bg = "dark_grey" },
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    local currentFile = vim.fn.expand('%:p')
    local filename = vim.fn.fnamemodify(currentFile, ':t')
    if filename == 'NvimTree_1' then return "" end
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color, bg = "dark_grey" }
  end
}

local FileName = {
  provider = function()
    -- first, trim the pattern relative to the current directory. For other
    -- options, see :h filename-modifers
    local currentFile = vim.fn.expand('%:p')
    local filename = vim.fn.fnamemodify(currentFile, ':t')
    if filename == 'NvimTree_1' then return "" end
    if filename == "" then return "[No Name]" end
    -- now, if the filename would occupy more than 1/4th of the available
    -- space, we trim the file path to its initials
    -- See Flexible Components section below for dynamic truncation
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = "white", bg = "dark_grey" },
}


-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
  ParentDirectory,
  FileIcon,
  utils.insert(FileName),   -- a new table where FileName is a child of FileNameModifier
  { provider = '%<' }       -- this means that the statusline is cut here when there's not enough space
)

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "gray" },

  {
      -- git branch name
    provider = function(self)
      return "  " .. self.status_dict.head
    end,
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = " ",
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (" " .. count)
    end,
    hl = { fg = "git_add" },
    -- hl = { fg = "gray" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = "git_del" },
    -- hl = { fg = "gray" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("  " .. count)
    end,
    hl = { fg = "git_change" },
    -- hl = { fg = "gray" },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = " ",
  },
}

local Diagnostics = {
  condition = conditions.has_diagnostics,

  static = {
    error_icon = "",
    warn_icon = "",
    info_icon = "",
    hint_icon = "",
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
}

-- local DAPMessages = {
--     condition = function()
--         local status_ok, session = pcall(require, "nvim-tree")
--         if not status_ok then
--           return
--         end
--         return session ~= nil
--     end,
--     provider = function()
--         return "⚙ " .. require("dap").status()
--     end,
--     hl = "Number"
--     -- see Click-it! section for clickable actions
-- }

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },

  -- You can keep it simple,
  -- provider = "⚙ LSP",

  -- Or complicate things a bit and get the servers names
  provider  = function()
      for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        if server.name ~= "null-ls" then
          return "󰖝 " .. string.format("%s", server.name)
        end
      end
      return ""
      -- local server = vim.lsp.get_active_clients({ bufnr = 0 })
      -- return "󰖝 " .. string.format("%s", server[1].name)
  end,
  hl = { fg = "yellow", bold = true },
}

-- We're getting minimalists here!
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  {
    provider = "🭁",
    hl = { fg = "purple", bg = "dark_grey" },
  },
  {
    provider = " ",
    hl = { fg = "dark_grey", bg = "purple" },
  },
  {
    provider = "🭗",
    hl = { fg = "purple", bg = "dark_grey" },
  },
  {
    provider = "%P ",
    hl = { fg = "purple", bold = true, bg = "dark_grey" },
  },
}

-- ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })
local DefaultStatusline = {
  ViMode, FileNameBlock, RightEdge, Git, Space, Align,
  Diagnostics, Space, LSPActive, Space, Ruler
}

-- local DefaultStatusline = {
--    LeftCap Space ViMode, Space, FileNameBlock, Space, Git, Space, Diagnostics, Align,
--    Navic, DAPMessages, Align,
--    LSPActive, Space, LSPMessages, Space, UltTest, Space, FileType, Space, Ruler, Space, ScrollBar
-- }

-- local InactiveStatusline = {
--   condition = conditions.is_not_active,
--   FileType, Space, FileName, Align,
-- }

-- local TerminalStatusline = {
--
--     condition = function()
--         return conditions.buffer_matches({ buftype = { "terminal" } })
--     end,
--
--     hl = { bg = "dark_red" },
--
--     -- Quickly add a condition to the ViMode to only show it when buffer is active!
--     { condition = conditions.is_active, ViMode, Space }, FileType, Space, TerminalName, Align,
-- }

local StatusLines = {
  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,

  -- the first statusline with no condition, or which condition returns true is used.
  -- think of it as a switch case with breaks to stop fallthrough.
  fallthrough = false,

  DefaultStatusline
}

require("heirline").setup({ statusline = StatusLines })
