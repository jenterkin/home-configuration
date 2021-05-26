require('packer').use {
    'hoob3rt/lualine.nvim',
    requires = {
        {'kyazdani42/nvim-web-devicons'},
        {'shaunsingh/nord.nvim', opt = true}
    },
    config = function()
        require('lualine').setup{options = { theme = 'nord' }}
    end
}
