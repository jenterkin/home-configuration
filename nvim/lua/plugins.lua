vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'dense-analysis/ale' -- TODO: look for lightweight auto-fixer
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {'neovim/nvim-lspconfig', config = function() vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc') end}
    use {'ms-jpq/chadtree', branch = "chad", run = 'python3 -m chadtree deps'}
    use {'shaunsingh/nord.nvim', config = function() require('nord').set() end}
    use '~/repos/vim-autosource'
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
            require("which-key").setup {}
        end
    }
end)
