

local function main()
  local isWindows = vim.loop.os_uname().sysname == "Windows_NT"

  local ui        = require('core.uiinit')
  ui.config(isWindows,'gruvbox')
  require('core.viopt').config()
  require('core.viplug').config(isWindows)
  require('core.vitree').config()

  if not isWindows then
    require('core.exinit')
  end

  ui.aucmd(isWindows)
end

main()
