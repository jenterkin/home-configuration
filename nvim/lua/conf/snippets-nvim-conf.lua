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
    local util = require('snippets.utils')
    snippets.use_suggested_mappings()

    -- Define snippets
    snippets.snippets = {
        _global = {
            todo = "TODO(jenterkin): "
        },
        lua = {
            ["for"] = util.match_indentation [[
for ${1}, ${2} in ipairs(${3}) do
    $0
end]]
        },
        python = {
            ["def"] = util.match_indentation [[
def ${1}(${2}):
    $0]],
            ["print"] = "print(${0})"
        }
    }
end
