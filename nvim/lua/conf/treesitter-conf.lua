require('packer').use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
	require('nvim-treesitter.configs').setup {
	    ensure_installed = 'maintained',  -- TODO: only enable langs I care about to optimize compile time
	    highlight = { enable = true }
	}
    end
}
