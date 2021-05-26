-- This file will automatically install packer if it does not exist
-- and will then run `:PackerInstall` and `:PackerCompile`

-- TODO: Can this module be made to suppress errors on initial startup?

-- Automatically compile on update on save and after install
-- `BufEnter` is a hack to compile after install. Note that this will compile after _each_ install,
-- and a side-effect is that if you enter a buffer with this file loaded, your scren will flicker
-- since `:PackerCompile` ran.
vim.cmd [[
augroup updatepacker
    autocmd!
    autocmd BufWritePost,BufEnter plugins.lua PackerCompile
augroup END
]]

local fn = vim.fn

local make_startup = function()
    vim.cmd [[packadd packer.nvim packer.luarocks]]

    require('packer').startup(function()
        use 'wbthomason/packer.nvim'

        use 'junegunn/vader.vim'

        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require('nvim-treesitter.configs').setup {
                    ensure_installed = 'maintained',  -- TODO: only enable langs I care about to optimize compile time
                    highlight = { enable = true }
                }
            end
        }

        use 'dense-analysis/ale' -- TODO: look for lightweight auto-fixer
        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }
        use {'neovim/nvim-lspconfig', config = function() vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc') end}
        use {'ms-jpq/chadtree', branch = "chad", run = 'python3 -m chadtree deps'}
        use {'shaunsingh/nord.nvim', config = function() require('nord').set() end}

        use 'jenterkin/vim-autosource'

        use {'airblade/vim-gitgutter', config = function() vim.g.updatetime = 100 end}
        use {'vim-python/python-syntax', config = function() vim.g.python_highlight_all = 1 end}
        use {
            'hoob3rt/lualine.nvim',
            requires = {
                {'kyazdani42/nvim-web-devicons'},
                {'shaunsingh/nord.nvim', opt = true}
            },
            config = function()
                require('lualine').setup{options = { theme = 'nord' }}
            end
        }
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup{}
            end
        }
        use {
            'hrsh7th/nvim-compe',
            config = function()
                vim.o.completeopt = 'menuone,noselect'
                require('compe').setup {
                    enabled = true,
                    autocomplete = true,
                    debug = false,
                    min_length = 1,
                    preselect = 'enable',
                    throttle_time = 80,
                    source_timeout = 200,
                    incomplete_delay = 400,
                    max_abbr_width = 100,
                    max_kind_width = 100,
                    max_menu_width = 100,
                    documentation = true,

                    source = {
                        path = true,
                        buffer = true,
                        calc = true,
                        nvim_lsp = true,
                        nvim_lua = true,
                        vsnip = true,
                        ultisnips = true
                    }
                }
            end
        }
        use {
            "folke/which-key.nvim",
            config = function()
                local wk = require('which-key')
                wk.setup {}
                wk.register({
                    ['<leader>'] = {
                        f = {
                            name = "+file",
                            f = {'<cmd>Telescope find_files<cr>', 'Find File'},
                            g = {'<cmd>Telescope git_files<cr>', 'Find File in Git'}
                        },
                        l = {
                            name = "+lsp",
                            i = {'<cmd>LspInfo<cr>', 'LSP Info'},
                            R = {'<cmd>LspRestart<cr>', 'LSP Restart'},
                            d = {'<cmd>Telescope lsp_document_diagnostics<cr>', 'Diagnostics'},
                            w = {'<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics'},
                            r = {'<cmd>Telescope lsp_references<cr>', 'Find References'},
                            g = {'<cmd>Telescope lsp_definitions<cr>', 'Go To Definition'},
                            a = {'<cmd>Telescope lsp_code_actions<cr>', 'Code Actions'}
                        }
                    }
                })
            end
        }
    end)
end

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

-- Make sure packer is installed
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    local startup = make_startup()
    vim.api.nvim_exec('execute ":PackerInstall"', false)
    return startup
end

return make_startup()
