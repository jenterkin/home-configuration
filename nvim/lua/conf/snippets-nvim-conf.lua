require('packer').use {
    'norcalli/snippets.nvim',
    config = function()
        define_snippets()

        -- <c-k> expand_or_advance(1)
        -- <c-j> expand_snippet(-1)
        require('snippets').use_suggested_mappings()
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
