require('packer').use {
    'airblade/vim-gitgutter',
    config = function()
        vim.g.updatetime = 100
    end
}
