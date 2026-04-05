-- vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.termguicolors = true -- Enable 24-bit RGB colours

-- Enable the new 0.12 native autocompletion
vim.opt.autocomplete = true 
-- Configure how the menu behaves
-- menuone: show even if there is only one suggestion
-- noselect: don't insert the text until you choose it
-- fuzzy: allow for typos while searching suggestions
vim.opt.completeopt = { "menuone", "noselect", "fuzzy" }

--Activate Theme
vim.cmd[[colorscheme tokyonight-storm]]

require("which-key").setup({})
