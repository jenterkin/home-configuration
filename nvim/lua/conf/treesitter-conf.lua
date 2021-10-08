local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

require('packer').use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
	require('nvim-treesitter.configs').setup {
	    ensure_installed = {
                'python',
                'typescript',
                'javascript',
                'ruby',
                'bash',
                'norg',
            },
	    highlight = { enable = true }
	}
    end
}
