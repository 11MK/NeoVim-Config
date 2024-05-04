-- 1) Markdown Inline Code Highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.textwidth = 79
		vim.opt_local.wrap = true
	end,
})


-- 2) Markdown Inline Code Highlighting
local languages = {'html', 'rust', 'python', 'lua', 'vim', 'typescript', 'javascript'}

local function cmd_string()
  local str = "let g:markdown_fenced_languages =["
  for i, lang in ipairs(languages) do
    str = str .. "'" .. lang .. "'"
    if i < #languages then
      str = str .. ", "
    end
  end
  str = str .. "]"
  return str
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = cmd_string()
})
