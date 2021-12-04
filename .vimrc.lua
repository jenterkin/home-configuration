require'lspconfig'.rnix.setup{}

vim.api.nvim_exec([[
autocmd BufWritePre *.nix :lua vim.lsp.buf.formatting()
]], false)
