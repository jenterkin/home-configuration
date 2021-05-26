require('packer').use {
    'norcalli/snippets.nvim',
    config = function()
        define_snippets()
        define_keymaps()
    end
}

function define_snippets()
    local snippets = require('snippets')
    snippets.use_suggested_mappings()

    -- Define snippets
    snippets.snippets = {
        _global = {
            todo = "TODO(jenterkin): "
        }
    }
end

function define_keymaps()
    vim.api.nvim_set_keymap(
        'n', '<c-k>', '<cmd>lua return require("snippets").expand_or_advance(1)<CR>',
        {noremap = true, silent = true}
    )
    vim.api.nvim_set_keymap(
        'n', '<c-j>', '<cmd>lua return require("snippets").expand_snippet(-1)<CR>',
        {noremap = true, silent = true}
    )
end
