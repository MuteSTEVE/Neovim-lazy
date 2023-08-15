local mark_ok, mark = pcall(require, 'harpoon.mark')
if not mark_ok then
  return
end

local ui_ok, ui = pcall(require, 'harpoon.ui')
if not ui_ok then
  return
end

local map = vim.keymap.set
map("n", "<C-a>", mark.add_file)
map("n", "<C-e>", ui.toggle_quick_menu)
map("n", "<leader>a", mark.add_file)
map("n", "<leader>e", ui.toggle_quick_menu)

map("n", "<C-h>", function() ui.nav_file(1) end)
map("n", "<C-t>", function() ui.nav_file(2) end)
map("n", "<C-n>", function() ui.nav_file(3) end)
map("n", "<C-s>", function() ui.nav_file(4) end)
