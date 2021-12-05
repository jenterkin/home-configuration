require('packer').use {
    'neovim/nvim-lspconfig',
    config = function()
        vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- set up global lsp integrations
        vim.g.capabilities = vim.lsp.protocol.make_client_capabilities()
        vim.g.capabilities.textDocument.completion.completionItem.snippetSupport = true
        vim.g.capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {
                'documentation',
                'detail',
                'additionalTextEdits',
            }
        }

        require('lspconfig').bashls.setup{capabilities = vim.g.capabilities}
    end
}
