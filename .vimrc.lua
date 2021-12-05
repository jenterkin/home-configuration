lsp = require('lspconfig')
lsp.rnix.setup{}
lsp.bashls.setup{}

vim.api.nvim_exec([[
autocmd! BufWritePost *.nix,*.sh :lua vim.lsp.buf.formatting()
]], false)
