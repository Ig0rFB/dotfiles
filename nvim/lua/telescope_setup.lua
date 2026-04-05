-- ~/.config/nvim/lua/telescope_setup.lua

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end

local builtin = require('telescope.builtin')

telescope.setup({
  defaults = {
    -- 1. Move prompt to top
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },

    -- 2. Modern UI Styling (Matching your screenshot)
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    border = true,
    -- Custom border characters for a cleaner, thin-line look
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  },
})

-- Define Keymaps (Using your Space leader)
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep (Text Search)" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List Open Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search Help Docs" })
