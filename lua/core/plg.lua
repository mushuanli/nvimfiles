
local M = {};


local function install_plugins(isWindows)
  local data_path = vim.fn.stdpath('data')
  local packer_subfile = '/site/pack/packer/start/packer.nvim'
  local install_path = data_path .. packer_subfile
  local packer_repo = 'https://github.com/wbthomason/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) then
    vim.fn.system({'git', 'clone', packer_repo, install_path})
    vim.cmd('packadd packer.nvim')
  end

  local packer = require('packer')

  packer.startup(function(use)
    use 'lewis6991/impatient.nvim'
    use 'wbthomason/packer.nvim'    -- let packer manage itself
    use "nathom/filetype.nvim"

    use 'ellisonleao/gruvbox.nvim'    -- let packer manage itself
    use 'junegunn/vim-easy-align'
    -- fuzzy finder over files, commands, lists, etc
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      }
    }

    -- Better syntax highlighting
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    --

    --[[ file tree
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {'kyazdani42/nvim-web-devicons'}
    }
]]--
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
          -- only needed if you want to use the commands with "_with_window_picker" suffix
          's1n7ax/nvim-window-picker',
          tag = "v1.*",
          config = function()
            require'window-picker'.setup({
              autoselect_one = true,
              include_current = false,
              filter_rules = {
                -- filter using buffer options
                bo = {
                  -- if the file type is one of following, the window will be ignored
                  filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },

                  -- if the buffer type is one of following, the window will be ignored
                  buftype = { 'terminal' },
                },
              },
              other_win_hl_color = '#e35e4f',
            })
          end,
        }
      },
      config = function ()
        -- Unless you are still migrating, remove the deprecated commands from v1.x
        vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

        -- If you want icons for diagnostic errors, you'll need to define them somewhere:
        vim.fn.sign_define("DiagnosticSignError",
          {text = " ", texthl = "DiagnosticSignError"})
        vim.fn.sign_define("DiagnosticSignWarn",
          {text = " ", texthl = "DiagnosticSignWarn"})
        vim.fn.sign_define("DiagnosticSignInfo",
          {text = " ", texthl = "DiagnosticSignInfo"})
        vim.fn.sign_define("DiagnosticSignHint",
          {text = "", texthl = "DiagnosticSignHint"})
        -- NOTE: this is changed from v1.x, which used the old style of highlight groups
        -- in the form "LspDiagnosticsSignWarning"

        require("neo-tree").setup({
          close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
          popup_border_style = "rounded",
          enable_git_status = true,
          enable_diagnostics = true,
          sort_case_insensitive = false, -- used when sorting files and directories in the tree
          sort_function = nil , -- use a custom function for sorting files and directories in the tree
          -- sort_function = function (a,b)
          --       if a.type == b.type then
          --           return a.path > b.path
          --       else
          --           return a.type > b.type
          --       end
          --   end , -- this sorts files and directories descendantly
          default_component_configs = {
            container = {
              enable_character_fade = true
            },
            indent = {
              indent_size = 2,
              padding = 1, -- extra padding on left hand side
              -- indent guides
              with_markers = true,
              indent_marker = "│",
              last_indent_marker = "└",
              highlight = "NeoTreeIndentMarker",
              -- expander config, needed for nesting files
              with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
              expander_collapsed = "",
              expander_expanded = "",
              expander_highlight = "NeoTreeExpander",
            },
            icon = {
              folder_closed = "",
              folder_open = "",
              folder_empty = "ﰊ",
              -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
              -- then these will never be used.
              default = "*",
              highlight = "NeoTreeFileIcon"
            },
            modified = {
              symbol = "[+]",
              highlight = "NeoTreeModified",
            },
            name = {
              trailing_slash = false,
              use_git_status_colors = true,
              highlight = "NeoTreeFileName",
            },
            git_status = {
              symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖",-- this can only be used in the git_status source
                renamed   = "",-- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
              }
            },
          },
          window = {
            position = "left",
            width = 40,
            mapping_options = {
              noremap = true,
              nowait = true,
            },
            mappings = {
              ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
              },
              ["<2-LeftMouse>"] = "open",
              ["<cr>"] = "open",
              ["S"] = "open_split",
              ["s"] = "open_vsplit",
              -- ["S"] = "split_with_window_picker",
              -- ["s"] = "vsplit_with_window_picker",
              ["t"] = "open_tabnew",
              ["w"] = "open_with_window_picker",
              ["C"] = "close_node",
              ["z"] = "close_all_nodes",
              --["Z"] = "expand_all_nodes",
              ["a"] = {
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                  show_path = "none" -- "none", "relative", "absolute"
                }
              },
              ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
              ["d"] = "delete",
              ["r"] = "rename",
              ["y"] = "copy_to_clipboard",
              ["x"] = "cut_to_clipboard",
              ["p"] = "paste_from_clipboard",
              ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
              -- ["c"] = {
              --  "copy",
              --  config = {
              --    show_path = "none" -- "none", "relative", "absolute"
              --  }
              --}
              ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
              ["q"] = "close_window",
              ["R"] = "refresh",
              ["?"] = "show_help",
            }
          },
          nesting_rules = {},
          filesystem = {
            filtered_items = {
              visible = false, -- when true, they will just be displayed differently than normal items
              hide_dotfiles = true,
              hide_gitignored = true,
              hide_hidden = true, -- only works on Windows for hidden files/directories
              hide_by_name = {
                --"node_modules"
              },
              hide_by_pattern = { -- uses glob style patterns
                --"*.meta"
              },
              never_show = { -- remains hidden even if visible is toggled to true
                --".DS_Store",
                --"thumbs.db"
              },
            },
            follow_current_file = false, -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
            -- in whatever position is specified in window.position
            -- "open_current",  -- netrw disabled, opening a directory opens within the
            -- window like netrw would, regardless of window.position
            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
            window = {
              mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
              }
            }
          },
          buffers = {
            follow_current_file = true, -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            group_empty_dirs = true, -- when true, empty folders will be grouped together
            show_unloaded = true,
            window = {
              mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
              }
            },
          },
          git_status = {
            window = {
              position = "float",
              mappings = {
                ["A"]  = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
              }
            }
          }
        })

        vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
      end
    }


    -- bufferline 显示标签页,与lualine配合使用
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

    -- completion engine
    if not isWindows then
      use {
        'hrsh7th/nvim-cmp',
        requires = {
          'hrsh7th/cmp-buffer',       -- text in current buffer
          'hrsh7th/cmp-nvim-lua',     -- neovim lua api
          'hrsh7th/cmp-path',         -- filesystem paths
          'L3MON4D3/LuaSnip',         -- nvim-cmp requires a snippet engine for expansion
          'saadparwaiz1/cmp_luasnip'  -- completion source for luasnip
        }
      }

      -- language server protocol
      use {
        'neovim/nvim-lspconfig',
        requires = {
          'hrsh7th/cmp-nvim-lsp',    -- lsp based completions
          'williamboman/nvim-lsp-installer'
        }
      }
      --状态栏插件
      use {
        "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
      }
      use "lukas-reineke/indent-blankline.nvim"
    end
    --
  end)


end

local function setup_plugins()

  require('impatient')  -- .enable_profile()
  -- In init.lua or filetype.nvim's config file
  require("filetype").setup({
      overrides = {
          extensions = {
              -- Set the filetype of *.pn files to potion
              pn = "potion",
          },
          literal = {
              -- Set the filetype of files named "MyBackupFile" to lua
              MyBackupFile = "lua",
          },
          complex = {
              -- Set the filetype of any full filename matching the regex to gitconfig
              [".*git/config"] = "gitconfig", -- Included in the plugin
          },

          -- The same as the ones above except the keys map to functions
          function_extensions = {
              ["cpp"] = function()
                  vim.bo.filetype = "cpp"
                  -- Remove annoying indent jumping
                  vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
              end,
              ["pdf"] = function()
                  vim.bo.filetype = "pdf"
                  -- Open in PDF viewer (Skim.app) automatically
                  vim.fn.jobstart(
                  "open -a skim " .. '"' .. vim.fn.expand("%") .. '"'
                  )
              end,
          },
          function_literal = {
              Brewfile = function()
                  vim.cmd("syntax off")
              end,
          },
          function_complex = {
              ["*.math_notes/%w+"] = function()
                  vim.cmd("iabbrev $ $$")
              end,
          },

          shebang = {
              dash = "sh",
          },
      },
  })

  require('bufferline').setup {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      numbers = "none",
      close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      indicator_icon = '▎',
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '|',
      right_trunc_marker = '|',
      name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
        if buf.name:match('%.md') then
          return vim.fn.fnamemodify(buf.name, ':t:r')
        end
      end,
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      tab_size = 18,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
          or (e == "warning" and " " or "")
          s = s .. sym
        end
        return s
      end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
          return true
        end
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          return true
        end
        -- filter out based on arbitrary rules
        -- e.g. filter out vim wiki buffer from tabline in your work repo
        if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
          return true
        end
        -- filter out by it's index number in list (don't show first buffer)
        if buf_numbers[1] ~= buf_number then
          return true
        end
      end,
      offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
        { filetype = "SymbolsOutline", text = "Symbols Outline", text_align = "center" } },
      color_icons = true,
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      sort_by = 'id'
    }
  }

end


function M.config(isWindows)
  install_plugins(isWindows)
  setup_plugins()
end

return M;
