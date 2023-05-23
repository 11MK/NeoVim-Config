local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "command mode" },
  },
  n = {
    ["<Space>w"] = { ":w <CR>", "save without exiting" },
    -- ["<C-k>"] = { "kzz", "center move up" },
    -- ["<C-j>"] = { "jzz", "center move down" },
    -- ["<F5>"] = { ":wa <bar> :set makeprg=cd && cmake -DCMAKE_BUILD_TYPE=debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ../homework && cmake --build . <bar> :compiler gcc <bar> :make <CR>", "center move down" },
  },

}

-- more keybinds!

return M
