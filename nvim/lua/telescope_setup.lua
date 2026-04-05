-- ~/.config/nvim/lua/telescope_setup.lua

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end

local builtin = require('telescope.builtin')

-- -- 1. Setup with some nice defaults
-- telescope.setup({
--   defaults = {
--     prompt_prefix = " 🔍 ",
--     selection_caret = "  ",
--     entry_prefix = "  ",
--     initial_mode = "insert",
--     sorting_strategy = "ascending",
--     layout_config = {
--       horizontal = {
--         prompt_position = "top",
--         preview_width = 0.55,
--       },
--     },
--   },
-- })

-- 2. Define Keymaps (Using your Space leader)
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep (Text Search)" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List Open Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search Help Docs" })
