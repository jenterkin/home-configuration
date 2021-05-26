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
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | exe "normal! zz" | endif
augroup END
]]

vim.api.nvim_set_option('timeoutlen', 0)
vim.g.mapleader = ','

vim.api.nvim_set_keymap('n', '<leader>t', ':CHADopen<cr>', {noremap = true, silent = true})

local wk = require('which-key')
wk.register({
    ['<leader>'] = {
        f = {
            name = "+file",
            f = {'<cmd>Telescope find_files<cr>', 'Find File'},
            g = {'<cmd>Telescope git_files<cr>', 'Find File in Git'}
        },
        l = {
            name = "+lsp",
            i = {'<cmd>LspInfo<cr>', 'LSP Info'},
	    R = {'<cmd>LspRestart<cr>', 'LSP Restart'},
            d = {'<cmd>Telescope lsp_document_diagnostics<cr>', 'Diagnostics'},
            w = {'<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics'},
	    r = {'<cmd>Telescope lsp_references<cr>', 'Find References'},
	    g = {'<cmd>Telescope lsp_definitions<cr>', 'Go To Definition'},
            a = {'<cmd>Telescope lsp_code_actions<cr>', 'Code Actions'}
        }
    }
})
