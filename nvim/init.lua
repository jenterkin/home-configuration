require("plugins")

local b = vim.bo        -- buffer
local g = vim.g         -- global
local w = vim.wo        -- window
local o = vim.o

o.autochdir = true

b.expandtab = true
b.shiftwidth = 4
b.autoindent = true
b.smartindent = true
o.mouse = 'a'

w.number = true
w.relativenumber = true

g.chadtree_settings = {theme = { text_colour_set = "nord" }}

-- Open file at last position
vim.cmd [[
augroup lastpos
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | exe "normal! zz" | endif
augroup END
]]

vim.api.nvim_set_option('timeoutlen', 0)
vim.g.mapleader = ','

-- require global lsp integrations
g.capabilities = vim.lsp.protocol.make_client_capabilities()
g.capabilities.textDocument.completion.completionItem.snippetSupport = true
g.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require('lspconfig').bashls.setup{capabilities = g.capabilities}

vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {noremap = true})
