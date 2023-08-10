local nvimtree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvimtree_ok then
    return
end

nvim_tree.setup ({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  -- diagnostics = {
  --   enable = true,
  --   icons = {
  --     hint = "",
  --     info = "",
  --     warning = "",
  --     error = "",
  --   },
  -- },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    number = false,
    relativenumber = false,
  },
  renderer = {
    indent_markers = { enable = true },
    root_folder_modifier = ":t",
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "󰉋",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
    }
  }
})

vim.g.nvim_tree_width = 25
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_indent_markers = 1

vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', { silent = true })   -- the key is ctrl+n
