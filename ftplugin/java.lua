local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local home = vim.env.HOME
local jdtls_path = vim.fn.stdpath "data" .. "/mason/packages/jdtls/"
local equinox_version = "1.6.500.v20230717-2134"

WORKSPACE_PATH = home .. "/School/DiscreteStructures/Program1"
if vim.fn.has "mac" == 1 then
  OS_NAME = "mac"
elseif vim.fn.has "unix" == 1 then
  OS_NAME = "linux"
elseif vim.fn.has "win32" == 1 then
  OS_NAME = "win"
else
  vim.notify("Unsupported OS", vim.log.levels.WARN, { title = "Jdtls" })
end

-- local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

local config = {
  cmd = {
    "java", -- or '/path/to/java17_or_newer/bin/java'

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    jdtls_path .. "plugins/org.eclipse.equinox.launcher_" .. equinox_version .. ".jar",

    "-configuration",
    jdtls_path .. "config_" .. OS_NAME,

    "-data",
    workspace_dir,
  },
  on_attach = require("plugins.lsp.handlers").on_attach,
  capabilities = require("plugins.lsp.handlers").capabilities,

}

local keymap = vim.keymap.set

keymap("n", "A-o", ":lua require'jdtls'.organize_imports()<cr>", { silent = true })
keymap("n", "crv", ":lua require'jdtls'.extract_variable()<cr>", { silent = true })
keymap("v", "crv", "<Esc>:lua require'jdtls'.extract_variable(true)<cr>", { silent = true })
keymap("n", "crc", ":lua require'jdtls'.extract_constant()<cr>", { silent = true })
keymap("v", "crc", "<Esc>:lua require'jdtls'.extract_constant(true)<cr>", { silent = true })
keymap("v", "crm", "<Esc>:lua require'jdtls'.extract_method(true)<cr>", { silent = true })

vim.cmd [[
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
command! -buffer JdtJol lua require('jdtls').jol()
command! -buffer JdtBytecode lua require('jdtls').javap()
command! -buffer JdtJshell lua require('jdtls').jshell()
]]

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
