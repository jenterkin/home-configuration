require('packer').use {
    "folke/which-key.nvim",
    config = function()
    local wk = require('which-key')
    wk.setup {}
    wk.register({
        ['<leader>'] = {
            p = {  -- packer
                name = "+packer",
                i = {'<cmd>PackerInstall<cr>'},
                c = {'<cmd>PackerCompile<cr>'}
            },
            f = {  -- files
                name = "+file",
                f = {'<cmd>Telescope find_files<cr>', 'Find File'},
                g = {'<cmd>Telescope git_files<cr>', 'Find File in Git'},
            s = {'<cmd>Telescope live_grep<cr>', 'Search String'}
            },
            g = {  -- git
                name = "+git",
                s = {'<cmd>Telescope git_status<cr>', 'Git Status'},
                b = {'<cmd>GitBlame<cr>', 'Git Blame'}
            },
            l = {  -- language server
                name = "+lsp",
                i = {'<cmd>LspInfo<cr>', 'LSP Info'},
                R = {'<cmd>LspRestart<cr>', 'LSP Restart'},
                d = {'<cmd>Telescope lsp_document_diagnostics<cr>', 'Diagnostics'},
                w = {'<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics'},
                r = {'<cmd>Telescope lsp_references<cr>', 'Find References'},
                g = {'<cmd>Telescope lsp_definitions<cr>', 'Go To Definition'},
                a = {'<cmd>Telescope lsp_code_actions<cr>', 'Code Actions'}
            },
            -- TODO: I added this to more easily run rspec tests, but should be generalized
            -- depending on the language.
            t = {
                name = "+test",
                -- Run current test
                c = {'<cmd>RunNearestSpec<cr>', 'Run Nearest Spec'}
            }
        }
    })
    end
}
