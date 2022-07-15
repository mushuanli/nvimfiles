local M = {};

-- ref: https://github.com/fsareshwala/dotfiles/blob/master/.config/nvim/init.lua
local function init_ui(isWindows,colorscheme)
  -- utf8
  vim.g.encoding                 = "UTF-8"
  vim.opt.fileencoding           = "utf-8"
  vim.g.homedir                  = os.getenv('HOME')
  vim.opt.clipboard              = "unnamedplus"

  -- improve load speed
  vim.g.do_filetype_lua          = 1
  vim.g.did_load_filetypes       = 0
  vim.g.loaded_gzip              = 1
  vim.g.loaded_tar               = 1
  vim.g.loaded_tarPlugin         = 1
  vim.g.loaded_zip               = 1
  vim.g.loaded_zipPlugin         = 1
  vim.g.loaded_getscript         = 1
  vim.g.loaded_getscriptPlugin   = 1
  vim.g.loaded_vimball           = 1
  vim.g.loaded_vimballPlugin     = 1
  vim.g.loaded_matchit           = 1
  vim.g.loaded_matchparen        = 1
  vim.g.loaded_2html_plugin      = 1
  vim.g.loaded_logiPat           = 1
  vim.g.loaded_rrhelper          = 1
  vim.g.loaded_netrw             = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_remote_plugins    = 1
  vim.g.loaded_shada_plugin      = 1


  --  UI
  vim.opt.background             = 'dark'
  vim.opt.showcmd                = true
  vim.opt.ttyfast                = true
  vim.opt.lazyredraw             = true
  vim.opt.termguicolors          = true   -- 样式

  vim.opt.updatetime             = 300    -- smaller updatetime
  vim.opt.timeoutlen             = 500  -- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
  vim.opt.shada                  = "!,'1000,<50,s10,h"

  vim.opt.background             = 'dark'
  if isWindows then
    vim.cmd [[
      language en_US
      source $VIMRUNTIME/mswin.vim
      call rpcnotify(0, 'Gui', 'Option', 'Popupmenu', 0)
      ]]
  end

  vim.cmd( "behave xterm | colorscheme " .. colorscheme)

  return isWindows
end

local function setup_autocmds(isWindows)

  -- return to the same line when you reopen a file
  vim.cmd [[
    augroup line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line('$') |
        \     execute 'normal! g`"zvzz' |
        \ endif
    augroup end
  ]]

  -- automatically delete all trailing whitespace and newlines at end of file on save
  vim.cmd [[
    augroup trailing_whitespace
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritepre * %s/\n\+\%$//e
    augroup end
  ]]

  -- autoclose nvim-tree if it's the last buffer open
  vim.cmd [[
    augroup autoclose_nvim_tree
    autocmd!
    autocmd BufEnter * ++nested
      \ if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() |
      \   quit |
      \ endif
    augroup end
  ]]
end

function M.config(isWindows,colorscheme)
  return init_ui(isWindows,colorscheme)
end

function M.aucmd(isWindows)
  setup_autocmds(isWindows)
end

return M;
