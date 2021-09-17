require('packer').use {
    'kristijanhusak/orgmode.nvim',
    config = function()
        require('orgmode').setup{}
    end
}

require('orgmode').setup({
    org_agenda_files = '~/Documents/notes/**/*'
})
