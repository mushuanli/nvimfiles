
local M = {};

local function setup_telescope()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    return
  end

  local actions = require('telescope.actions')

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-p>'] = actions.preview_scrolling_up,
          ['<C-n>'] = actions.preview_scrolling_down,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ["<C-h>"] = "which_key",
    	    ['<c-d>'] = actions.delete_buffer
        }, -- n
        n = {
          ['<c-d>'] = actions.delete_buffer
        } -- i
      }
    },
    file_ignore_patterns = {"./node_modules"}
  }

  telescope.load_extension('fzf')
end

local function setup_treesitter()
  local ok, configs = pcall(require, 'nvim-treesitter.configs')
  if not ok then
    return
  end

  configs.setup {
    ensure_installed      = {"go", "lua", "javascript", "c"},
    sync_install          = false,
    highlight = {
      enable              = true,
      additional_vim_regex_highlighting = true,
    },
    -- 启用增量选择
    incremental_selection = {
      enable              = true,
      keymaps = {
        init_selection    = '<CR>',
        node_incremental  = '<CR>',
        node_decremental  = '<BS>',
        scope_incremental = '<TAB>',
      }
    },
    -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
    indent = {
      enable              = true
    }
  }

  -- 开启 Folding
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
  -- 默认不要折叠
  -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
  vim.wo.foldlevel = 99
  -- vim.wo.foldopen -= 'search'
end

local function setup_filetree()
  local ok, filetree = pcall(require, 'nvim-tree')
  if not ok then
    return
  end

  filetree.setup({
    open_on_setup                      = true,
    hijack_cursor                      = true,
    hijack_unnamed_buffer_when_opening = false,
    open_on_tab                        = true,
    reload_on_bufenter                 = true,
    update_cwd                         = true,
    view    = {
      side                             = 'left',
      width                            = 35,
      number                           = false,
      relativenumber                   = false,
      signcolumn                       = "yes"
    },
    git     = {
      enable                           = false,
      ignore                           = false
    },
    filters = {
      dotfiles                         = true,
      custom                           = {'.git'},
    },
    update_focused_file = {
      enable                           = true,
      update_cwd                       = false
    },
    renderer            = {
      group_empty                      = true,
      full_name                        = true,
    },
    actions             = {
      open_file                        = {
        resize_window                  = true,
      },
    }
  })
end


function M.config()
  setup_telescope()
  setup_treesitter()
  setup_filetree()
end

return M;
