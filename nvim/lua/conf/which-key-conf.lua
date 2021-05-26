require('packer').use {
    "folke/which-key.nvim",
    config = function()
    local wk = require('which-key')
    wk.setup {}
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
    end
}
