local status_ok, starter = pcall(require, "mini.starter")
if not status_ok then return end

starter.setup({
  header = table.concat({
    "          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
    "          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
    "          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
  }, "\n"),
  items = {
    { name = "Find File",    action = "Telescope find_files", section = "Actions" },
    { name = "New File",     action = "enew | startinsert",   section = "Actions" },
    { name = "Find Text",    action = "Telescope live_grep",  section = "Actions" },
    { name = "Recent Files", action = "Telescope oldfiles",   section = "Actions" },
    { name = "Configs",      action = "Telescope find_files cwd=" .. vim.fn.expand("~/dotfiles"), section = "Actions" },
    { name = "Mason",        action = "Mason",                section = "Actions" },
    { name = "Quit",         action = "qa",                   section = "Actions" },
    { name = "Git Status",   action = "Telescope git_status", section = "Actions" },
    -- This section adds your 5 most recent files automatically
    starter.sections.recent_files(5, false, false),
  },
  footer = "",
})

-- Add shortcut to go back to the starter page with a safety check for unsaved changes
vim.keymap.set('n', '<leader>s', function()
  if vim.bo.modified then
    local choice = vim.fn.confirm("Save changes before going to Starter?", "&Yes\n&No\n&Cancel", 3)
    if choice == 1 then -- Yes
      vim.cmd("write")
    elseif choice == 0 or choice == 3 then -- Cancel or Esc
      return
    end
    -- If choice is 2 (No), we just proceed to open the starter
  end
  starter.open()
end, { desc = "Go to Starter Page" })
