local M = {}

function M.setup()
  config = require('config')

  local packer_bootstrap = function()
    local fn = vim.fn

    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
      vim.cmd('packadd packer.nvim')

      return true
    end

    return false
  end

  local first_packer_run = packer_bootstrap()

  local packer = require('packer')

  packer.startup(function(use)
    use('wbthomason/packer.nvim') -- Packer itself

    -- Aesthetics
    use({
      'catppuccin/nvim',
      as = 'catppuccin',
      config = function()
        require('catppuccin').setup({
          flavour = config.catppuccin_flavor
        })

        vim.cmd('colorscheme catppuccin')
      end
    })
    use({
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup({
          options = {
            theme = 'catppuccin'
          }
        })
      end
    })
    use({
      'lukas-reineke/virt-column.nvim',
      config = function()
        vim.opt.colorcolumn = config.virt_column_column

        require('virt-column').setup()
      end
    })
    use({
      'nvim-tree/nvim-tree.lua',
      config = function()
        vim.g.loaded_netrw = true
        vim.g.loaded_netrwPlugin = true
        vim.opt.termguicolors = true

        require('nvim-tree').setup({
          sort_by = 'case_sensitive',
          view = {
            width = config.nvim_tree_width
          },
          tab = {
            sync = {
              open = true
            }
          },
          update_focused_file = {
            enable = true,
            update_root = true
          }
        })

        vim.cmd('NvimTreeOpen')
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<c-w>w', true, false, true), 'n', false
        )
      end
    })
    use({
      'luochen1990/rainbow',
      config = function()
        vim.g.rainbow_active = true
      end
    })

    -- Mason
    use('williamboman/mason.nvim')
    use({
      'WhoIsSethDaniel/mason-tool-installer',
      config = function()
        require('mason-tool-installer').setup({
          ensure_installed = config.mason_tools,
          auto_update = true
        })
      end
    })
    use({
      'williamboman/mason-lspconfig',
      config = function()
        require('mason').setup()

        require('mason-lspconfig').setup({
          ensure_installed = config.mason_lsps
        })
      end
    })

    -- Actual coding support
    use('neovim/nvim-lspconfig')
    use({
      'mfussenegger/nvim-lint',
      config = function()
        require('lint').linters_by_ft = config.nvim_lint_linters
      end
    })
    use({
      'mhartington/formatter.nvim',
      config = function()
        local formatter_config = {
          filetype = config.other_formatters
        }

        for _, filetype in ipairs(config.prettier_filetypes) do
          formatter_config.filetype[filetype] = { require('formatter.defaults.prettier') }
        end

        require('formatter').setup(formatter_config)
      end
    })
    use({
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('nvim-treesitter.configs').setup({
          ensure_installed = 'all',
          highlight = {
            enable = true
          }
        })

        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
        vim.opt.foldenable = false
      end
    })
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        {
          'hrsh7th/cmp-vsnip',
          requires = {
            'hrsh7th/vim-vsnip'
          }
        }
      },
      config = function()
        local cmp = require('cmp')

        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn['vsnip#anonymous'](args.body)
            end
          },
          mapping = {
            ['<PageUp>'] = cmp.mapping.scroll_docs(-4),
            ['<PageDown>'] = cmp.mapping.scroll_docs(4),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
            ['<CR>'] = cmp.mapping.confirm({ select = false })
          },
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'vsnip' }
          }, {
            { name = 'buffer' }
          })
        })

        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        for _, lsp in ipairs(config.lsps) do
          local capabilities = cmp_nvim_lsp.default_capabilities()
          capabilities.workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = false
            }
          }
          if lsp ~= 'pylsp' then
            lspconfig[lsp].setup({
              capabilities = capabilities
            })
          else
            lspconfig[lsp].setup({
              capabilities = capabilities,
              settings = {
                pylsp = {
                  plugins = {
                    pycodestyle = {
                      enabled = false
                    }
                  }
                }
              }
            })
          end
        end
      end
    })

    -- Misc
    use({
      'tpope/vim-sleuth',
      config = function()
        vim.opt.expandtab = true
      end
    })
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      config = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end
    })
    use({
      'cohama/lexima.vim',
      config = function()
        vim.g.lexima_enable_basic_rules = true
      end
    })
    use({
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup({
          current_line_blame = true,
          current_line_blame_opts = {
            delay = 0
          }
        })
      end
    })
    use('nvim-lua/plenary.nvim')
    use({
      'folke/todo-comments.nvim',
      config = function()
        require('todo-comments').setup()
      end
    })
    use({
      'nvim-neotest/neotest',
      requires = {
        'antoinemadec/FixCursorHold.nvim',
        'nvim-neotest/neotest-python'
      },
      config = function()
        require('neotest').setup({
          adapters = {
            require('neotest-python')
          }
        })
      end
    })
    use({
      's1n7ax/nvim-window-picker',
      config = function()
        local window_picker = require('window-picker')

        window_picker.setup({
          selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          -- Disable filtering to make nvim-tree and terminal pickable
          filter_rules = {
            bo = {
              filetype = {},
              buftype = {}
            }
          },
          highlights = {
            statusline = {
              unfocused = {
                fg = '#232634',
                bg = '#8ca9ee',
                bold = true
              }
            }
          }
        })

        local pick_window = function()
          local window_id = window_picker.pick_window()

          if window_id ~= nil then
            vim.api.nvim_set_current_win(window_id)
          end

          vim.notify(
            '',
            vim.log.levels.OFF
          )
        end

        vim.keymap.set('n', '<c-w><c-w>', pick_window)
        vim.keymap.set('n', '<c-w>w', pick_window)
      end
    })
    if config.use_wakatime then
      use('wakatime/vim-wakatime')
    end
    use('numToStr/FTerm.nvim')
  end)

  if first_packer_run then
    packer.sync()
  end
end

return M
