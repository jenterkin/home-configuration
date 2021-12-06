-- This file will automatically install packer if it does not exist
-- and will then run `:PackerInstall` and `:PackerCompile`

-- add confs to lua path
package.path = './conf/?.lua;' .. package.path

-- TODO: Can this module be made to suppress errors on initial startup?

local fn = vim.fn

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

function use_local(packages)
    for _, package in ipairs(packages) do
        require('conf/'..package)
    end
end

local make_startup = function()
    vim.cmd [[packadd packer.nvim packer.luarocks]]

    require('packer').startup(function()
        -- Packages with no configuration
        use {
            'wbthomason/packer.nvim',

	    'thoughtbot/vim-rspec',
            -- 'dense-analysis/ale', -- TODO: look for lightweight auto-fixer
            'jenterkin/vim-autosource',
            'junegunn/vader.vim',
            'nvim-lua/plenary.nvim',
	    'zah/nim.vim',
        }

        use_local {
            'compe-conf',
            'fugitive',
            'gitgutter-conf',
            'lspconfig-conf',
            'lualine-conf',
            'nord-conf',
            'snippets-nvim-conf',
            'telescope-conf',
            'treesitter-conf',
            'trouble-conf',
            'which-key-conf',
        }
    end)
end

-- Make sure packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    local startup = make_startup()
    vim.api.nvim_exec('execute ":PackerInstall"', false)
    return startup
end

return make_startup()
