local M = {};

local function set_options()

  -- Edit
  -- 当文件被外部程序修改时，自动加载
  vim.opt.autoread               = true
  vim.opt.autowriteall           = true
  vim.opt.confirm                = true

  -- 鼠标支持
  vim.opt.mouse                  = 'nvi'  -- 鼠标模式
  vim.opt.mousehide              = true
  vim.opt.number                 = true   -- 显示行号
  vim.opt.ruler                  = true   -- 显示
  vim.opt.splitbelow             = true   -- split window 从下边和右边出现
  vim.opt.splitright             = true
  vim.opt.cursorline             = false   -- 高亮所在行,比较费性能
  vim.wo.signcolumn              = "yes"  -- 显示左侧图标指示列
  vim.wo.colorcolumn             = "80"   -- 右侧参考线，超过表示代码太长了，考虑换行
  vim.opt.cmdheight              = 1      -- 命令行高为2，提供足够的显示空间
  vim.wo.wrap                    = false  -- 禁止折行
  vim.opt.showtabline            = 2      -- 永远显示 tabline
  vim.opt.laststatus             = 3      -- enable global status line
  vim.opt.showmode               = false  -- 使用增强状态栏插件后不再需要 vim 的模式提示
  vim.opt.backspace              = {'eol', 'start', 'indent'}
  vim.opt.spell                  = false  -- 禁止拼写检查
  vim.opt.showmatch              = true   -- 显示括号匹配, 时间3秒
  vim.opt.matchtime              = 3

  -- jkhl 移动时光标周围保留8行
  vim.opt.scrolloff              = 8
  vim.opt.sidescrolloff          = 15
  vim.opt.scrolljump             = 3
  vim.opt.whichwrap              = "<,>,[,]"  -- 光标在行首尾时<Left><Right>可以跳到下一行
  vim.opt.hidden                 = true   -- 允许隐藏被修改过的buffer

  vim.opt.hlsearch               = true   -- 搜索不要高亮
  vim.opt.incsearch              = true   -- 边输入边搜索
  vim.opt.ignorecase             = true   -- 搜索大小写不敏感，除非包含大写
  vim.opt.smartcase              = true
  vim.opt.grepprg                = "rg --with-filename --no-heading --line-number --column --hidden --smart-case --follow"
  vim.opt.grepformat             = "%f:%l:%c:%m"

  vim.opt.formatoptions          = 'cjlnqrt'  -- 代码缩进
  vim.opt.autoindent             = true
  vim.opt.smartindent            = true
  vim.opt.copyindent             = true
  vim.opt.preserveindent         = true
  vim.opt.tabstop                = 8      -- tab缩进
  vim.opt.softtabstop            = 2
  vim.opt.expandtab              = true
  vim.opt.smarttab               = true
  -- >> << 时移动长度
  vim.opt.shiftwidth             = 2

  -- 禁止创建备份文件
  vim.opt.backup                 = false
  vim.opt.writebackup            = false
  vim.opt.swapfile               = false
  vim.opt.undofile               = true
  vim.opt.sessionoptions         = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
  vim.opt.diffopt                = "internal,filler,closeoff,vertical,foldcolumn:0"

  vim.g.completeopt              = "menu,menuone,noselect,noinsert"   -- 自动补全不自动选中
  vim.opt.pumheight              = 10     -- 补全最多显示10行
  vim.opt.list                   = false  -- 是否显示不可见字符
  vim.opt.listchars              = {tab = '|-', trail = '-', extends = '>', precedes = '<',eol = '↴'} -- 不可见字符的显示，这里只把空格显示为一个点
  -- vim.opt.shortmess        = vim.opt.shortmess .. "c"     -- Dont' pass messages to |ins-completin menu|
  vim.opt.wildmode               = 'list:longest,full'
  vim.opt.wildignore:append({'**/node_modules/**','.git','*.so', '*.o','*.dll','*.exe','*.obj','*.d','*.zip','*.e','*.pyc','*.pyo','*~','*.bak','*.sw?','*.jpg','*.bmp','*.gif','*.png'})
  vim.opt.wildmenu               = true

  -- status bar
  local statusLineComponents = {
      -- Used to put the mode, but if terminal can change cursor shape, it really isn't required.
      '%2*%-3.3n%0* %f ',   -- File name
      "%h%1*%m%r%w%0* ",
      "%{&ff!='unix'?'['.&ff.'] ':''}",  -- File format (unix vs. dos)
      "%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.'] ':''}",
      '%{&encoding}', -- current encoding
      '%y %m%r',   -- file type, modify, readonly
      '%=',    -- makes following right aligned
      "%#warningmsg#",
      "%*",
      "0x%-8B %-14.(%l,%c%V%) %<%P ",
      'C:%c ',  -- column number
      '%p%% ',  -- percentage through file
    --'%{strftime("%d/%m - %H:%M")}'
  }

  vim.opt.statusline = table.concat(statusLineComponents)
end

local function set_keymaps()
  local silent = { silent = true, noremap = true }

  vim.api.nvim_set_keymap("i",[[']],[[''<ESC>i]],silent)
  vim.api.nvim_set_keymap("i",[["]],[[""<ESC>i]],silent)
  vim.api.nvim_set_keymap("i",[[(]],[[()<ESC>i]],silent)
  vim.api.nvim_set_keymap("i",'[','[]<ESC>i',silent)
  vim.api.nvim_set_keymap("i",'{','{<CR>}<ESC>O',silent)

  vim.api.nvim_set_keymap("n",'<leader>e',':ToggleTerm<CR>',silent)
  vim.api.nvim_set_keymap("n",'<F4>','zO',silent)
  vim.api.nvim_set_keymap("n",'<F5>','zR',silent)
  vim.api.nvim_set_keymap("n",'<F6>','zM',silent)
  vim.api.nvim_set_keymap("n",'<F7>',':cn<CR>',silent)
  -- vim.api.nvim_set_keymap("v","<LeftRelease>", '"*ygv',silent)
  vim.api.nvim_set_keymap("n",'<c-h>', '<c-w>h',silent)
  vim.api.nvim_set_keymap("n",'<c-j>', '<c-w>j',silent)
  vim.api.nvim_set_keymap("n",'<c-k>', '<c-w>k',silent)
  vim.api.nvim_set_keymap("n",'<c-l>', '<c-w>l',silent)
  vim.api.nvim_set_keymap("n",'<leader>s', ':vsplit<cr>',silent)
  vim.api.nvim_set_keymap("n",'<leader>t', ':tabnew<cr>',silent)
  vim.api.nvim_set_keymap("n",'H', ':tabprev<cr>',silent)
  vim.api.nvim_set_keymap("n",'L', ':tabnext<cr>',silent)
  vim.api.nvim_set_keymap("n",'<leader>q', ':bd<cr>',silent)
  -- resize with arrows
  vim.api.nvim_set_keymap("n",'<M-up>', ':resize +2<cr>',silent)
  vim.api.nvim_set_keymap("n",'<M-down>', ':resize -2<cr>',silent)
  vim.api.nvim_set_keymap("n",'<M-left>', ':vertical resize -2<cr>',silent)
  vim.api.nvim_set_keymap("n",'<M-right>', ':vertical resize +2<cr>',silent)
  -- format
  vim.api.nvim_set_keymap("v",'<', '<gv',silent)
  vim.api.nvim_set_keymap("v",'>', '>gv',silent)
  -- stay at current word when using star search
  vim.api.nvim_set_keymap("n",'ga', '<Plug>(EasyAlign)',silent)
  vim.api.nvim_set_keymap("x",'ga', '<Plug>(EasyAlign)',silent)

  -- telescope keymaps
  -- vim.api.nvim_set_keymap("n",'<leader>fG', '<cmd>Telescope grep_string<cr>',silent)
  -- vim.api.nvim_set_keymap("n",'<leader>z', '<cmd>Telescope spell_suggest<cr>',silent)
  -- vim.api.nvim_set_keymap("n",'<leader>fx', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',silent)
  vim.api.nvim_set_keymap("n","<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]],silent)
  vim.api.nvim_set_keymap("n","<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],silent)
  vim.api.nvim_set_keymap("n","<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]],silent)
  vim.api.nvim_set_keymap("n","<leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<cr>]],silent)
  -- vim.api.nvim_set_keymap("n","<leader>sf", [[<cmd>lua require('telescope.builtin').file_browser()<cr>]],silent)
  vim.api.nvim_set_keymap("n","<leader>/", [[<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>]],silent)
  vim.api.nvim_set_keymap("n","<C-p>", [[<cmd>lua require('telescope.builtin').find_files()<cr>]],silent)
  vim.api.nvim_set_keymap("n","<C-b>", [[<cmd>lua require('telescope.builtin').buffers()<cr>]],silent)
  vim.api.nvim_set_keymap("n","<C-a>", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],silent)
  vim.api.nvim_set_keymap("n","<C-s>", [[<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>]],silent)

  -- file tree keymaps
  -- vim.api.nvim_set_keymap("n",'<leader>n', '<cmd>NvimTreeToggle<cr>',silent)
  vim.api.nvim_set_keymap("n", "<leader>n", ":NeoTreeShowToggle<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n",'<leader>b', ':Neotree toggle show buffers<cr>',silent)
  vim.api.nvim_set_keymap("n",'<leader>g', ':Neotree flow git_status<cr>',silent)

  vim.api.nvim_set_keymap("n", "<leader>l", ":bnext<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<leader>h", ":bprevious<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<leader>do", ":DiffviewOpen<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<leader>dc", ":DiffviewClose<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "gb", "<Cmd>BufferLinePick<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "[b", ":BufferLineCycleNext<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "]b", ":BufferLineCyclePrev<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", {noremap = true, silent = true})
end

function M.config()
  set_options()
  set_keymaps()
end

return M;
