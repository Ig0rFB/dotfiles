vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.pack.add({
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/catppuccin/nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/folke/which-key.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/debugloop/telescope-undo.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/echasnovski/mini.nvim',
})


-- Load my other config files
require("remap")
require ("common")
require ("lua_line")
require ("lsp_config")
require ("telescope_setup")
require ("starter")

-- Space + f + c (Find Config)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fc', function()
    builtin.find_files({
        prompt_title = "Neovim Configuration",
        cwd = vim.fn.expand("~/dotfiles/nvim"),
    })
end, { desc = "Find Nvim Dotfiles" })
