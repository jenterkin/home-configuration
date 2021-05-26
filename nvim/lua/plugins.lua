-- Automatically compile on update on save and after install
-- `BufEnter` is a hack to compile after install
vim.cmd [[
augroup updatepacker
    autocmd!
    autocmd BufWritePost,BufEnter plugins.lua PackerCompile
augroup END
]]

-- Make sure packer.nvim is installed
-- On initial install you will be met with an error. Hit enter and `:PackerInstall` will run.
-- You will still have to manually run `:PackerCompile or save this file`
local fn = vim.fn
local fresh_install = false
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fresh_install = true
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim packer.luarocks]]

local startup = require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'https://github.com/junegunn/vader.vim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = 'maintained',
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

if fresh_install == true then
    vim.api.nvim_exec('execute ":PackerInstall"', false)
    -- TODO: Figure out how to call `:PackerCompile` after `:PackerInstall` returns
end

return startup
