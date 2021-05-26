require('packer').use {
    'neovim/nvim-lspconfig',
    config = function()
        vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end
}
