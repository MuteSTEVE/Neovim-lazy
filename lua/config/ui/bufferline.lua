local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
  return
end

local bufferlineconfig_ok, bufferline_config = pcall(require, "bufferline.config")
if not bufferlineconfig_ok then
  return
end

-- Function to run a shell command and capture its output
local function capture_shell_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result:gsub("\n$", "") -- Remove trailing newline
end

vim.opt.termguicolors = true

bufferline.setup {
  options = {
    tab_size = auto,
    indicator = {
      icon = '▎ ', -- this should be omitted if indicator style is not 'icon'
      --icon = ' ', -- this should be omitted if indicator style is not 'icon'
      style = 'icon',
    },
    modified_icon = '󰣕',
    buffer_close_icon = '',
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    color_icons = true,
    highlights = {
      buffer_close_icon = {
        guifg = '#FF0000',
        guibg = '#FF0000',
      },
    },
    -- diagnostics = "nvim_lsp",
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    --   local icon = level:match("error") and " " or " "
    --   if context.buffer:current() then
    --     return "" .. icon .. count
    --   end

    --     return ''
    -- end
    offsets = {
      {
        filetype = 'NvimTree',
        text = capture_shell_command("bash -c 'pwd'"), -- Run 'bash command pwd'
        highlight = 'Directory',
        text_align = 'center',
      },
    },
    -- custom_areas = {
    --   left = function()
    --     return {
    --       { text = '    ', fg = '#1688f0' },
    --     }
    --   end,
    -- },
  }
}

-- Bufferline keybind
local map = vim.api.nvim_set_keymap
map('n', 'Z', ':bp<CR>', { noremap = true, silent = true})
map('n', 'C', ':bn<CR>', { noremap = true, silent = true})
map('n', 'X', ':bd<CR>', { noremap = true, silent = true})

vim.g.transparent_groups = vim.list_extend(
  vim.g.transparent_groups or {},
  vim.tbl_map(function(v)
    return v.hl_group
  end, vim.tbl_values(bufferline_config.highlights))
)
