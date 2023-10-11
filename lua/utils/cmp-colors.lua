local function set_cmp_highlights()
	local ns_ids = {
		"CmpItemKindField",
		"CmpItemKindProperty",
		"CmpItemKindEvent",
		"CmpItemKindText",
		"CmpItemKindEnum",
		"CmpItemKindKeyword",
		"CmpItemKindConstant",
		"CmpItemKindConstructor",
		"CmpItemKindReference",
		"CmpItemKindFunction",
		"CmpItemKindStruct",
		"CmpItemKindClass",
		"CmpItemKindModule",
		"CmpItemKindOperator",
		"CmpItemKindVariable",
		"CmpItemKindFile",
		"CmpItemKindUnit",
		"CmpItemKindSnippet",
		"CmpItemKindFolder",
		"CmpItemKindMethod",
		"CmpItemKindValue",
		"CmpItemKindEnumMember",
		"CmpItemKindInterface",
		"CmpItemKindColor",
		"CmpItemKindTypeParameter",
	}
  -- Icon Highlights
	local background = vim.api.nvim_get_hl_by_name("StatusLine", { attributes = true }).background
	for _, ns in pairs(ns_ids) do
		local highlight = vim.api.nvim_get_hl_by_name(ns, {
			attributes = true,
		})
		local foreground = string.format("#%06x", highlight.foreground)
    local opts = {}
    opts.foreground = foreground
    opts.background = background
    if ns == "CmpItemAbbrDeprecated" then
      opts.strikethrough = true
    elseif ns == "CmpItemMenu" then
      opts.italic = true
    end
    vim.api.nvim_set_hl(0,ns,opts)
	end
  -- Menu Highlights
  local foreground = vim.api.nvim_get_hl_by_name("LineNr", { attributes = true }).foreground
  vim.api.nvim_set_hl(0,"CmpItemMenu", { fg = foreground, italic=true })
  -- Abbreviation Highlights
  foreground = vim.api.nvim_get_hl_by_name("LineNr", { attributes = true }).foreground
  vim.api.nvim_set_hl(0,"CmpItemAbbrDeprecated", { fg = foreground, strikethrough = true })
  foreground = vim.api.nvim_get_hl_by_name("LineNr", { attributes = true }).foreground
  vim.api.nvim_set_hl(0,"CmpItemAbbrMatch", { fg = foreground })
  foreground = vim.api.nvim_get_hl_by_name("LineNr", { attributes = true }).foreground
  vim.api.nvim_set_hl(0,"CmpItemAbbrMatchFuzzy", { fg = foreground })
end

set_cmp_highlights()
