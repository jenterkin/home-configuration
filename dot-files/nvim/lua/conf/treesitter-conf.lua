-- local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

require('packer').use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
	require('nvim-treesitter.configs').setup {
	    ensure_installed = {
                'astro',
                'bash',
                'javascript',
                'nix',
                'python',
                'ruby',
                'typescript',
            },
	    highlight = { enable = true }
	}
    end
}
