require'lspconfig'.rnix.setup{}

vim.api.nvim_exec([[
autocmd BufWritePost *.nix :lua vim.lsp.buf.formatting()
]], false)
