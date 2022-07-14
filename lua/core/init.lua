

local function main()
  local isWindows = vim.loop.os_uname().sysname == "Windows_NT"

  local ui        = require('core.ui')
  ui.config(isWindows,'gruvbox')
  require('core.opt').config()
  require('core.plg').config(isWindows)
  require('core.scope').config()

  if not isWindows then
    require('core.lsp').config()
  end

  ui.aucmd(isWindows)
end

main()
