-- Map Leader key
vim.g.mapleader = ' '

-- Define map as keybind
local map = vim.api.nvim_set_keymap
local mapset = vim.keymap.set

-- Some useful keybinds VSCode move line keybind
map('n', '<Left>', '<C-w>h', { noremap = true, silent = false })
map('n', '<Down>', '<C-w>j', { noremap = true, silent = true })
map('n', '<Up>', '<C-w>k', { noremap = true, silent = true })
map('n', '<Right>', '<C-w>l', { noremap = true, silent = true })

map('n', 'K', ":move .-2<CR>==", { noremap = true, silent = true })
map('n', 'J', ":move .+1<CR>==", { noremap = true, silent = true })
map('v', 'K', ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
map('v', 'J', ":move '>+1<CR>gv-gv", { noremap = true, silent = true })

-- Move between panes quickly
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})

-- Get out of insert mode quickly
map('i', 'ka', '<ESC>', {noremap = true, silent = false})
map('i', 'ak', '<ESC>', {noremap = true, silent = false})
map('v', 'ak', '<ESC>', {noremap = true, silent = false})
map('v', 'ka', '<ESC>', {noremap = true, silent = false})

-- Indent
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

-- middle cursor
mapset("n", "<C-d>", "<C-d>zz")
mapset("n", "<C-u>", "<C-d>zz")

-- middle search
mapset("n", "n", "nzzzv")
mapset("n", "N", "Nzzzv")

map('n', 'Z', ':bp<CR>', { noremap = true, silent = true})
map('n', 'C', ':bn<CR>', { noremap = true, silent = true})
map('n', 'X', ':bd<CR>', { noremap = true, silent = true})
