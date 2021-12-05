require('packer').use {
    "akinsho/org-bullets.nvim",
    config = function()
        require("org-bullets").setup {
            symbols = { "◉", "○", "✸", "✿" }
        }
    end
}
