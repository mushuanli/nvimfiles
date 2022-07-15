

local function main()
  local isWindows = vim.loop.os_uname().sysname == "Windows_NT"

  local ui        = require('ui')
  ui.config(isWindows,'gruvbox')
  require('opt').config()
  require('plg').config(isWindows)
  require('scope').config()

  if not isWindows then
    require('statbar').config()
    require('term').config()
    require('lsp').config()
  end

  ui.aucmd(isWindows)
end

main()
