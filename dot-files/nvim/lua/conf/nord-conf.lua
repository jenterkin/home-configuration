require('packer').use {
    'shaunsingh/nord.nvim',
    config = function()
        require('nord').set()
    end
}
