local lualine_ok, lualine = pcall(require, 'lualine')
if not lualine_ok then
	return
end

local noice_ok, noice = pcall(require, 'noice')
if not noice_ok then
 return
end

-- cool function for progress
local progress_bar = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

lualine.setup {
  options = {
    icons_enabled = true,
    -- theme = 'material-stealth',
    -- theme = 'fluoromachine',
    -- theme = 'tokyonight',
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      'packer',
      'alpha',
      'NvimTree',
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
    transparent = true,
  },
  sections = {
    lualine_a = {
      {
        'buffers',
        show_filename_only = true,   -- Shows shortened relative path when set to false.
        hide_filename_extension = false,   -- Hide filename extension when set to true.
        show_modified_status = true, -- Shows indicator when the buffer is modified.
        mode = 0, -- 0: Shows buffer name
        max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
        symbols = {
          modified = ' ●',      -- Text to show when the buffer is modified
          alternate_file = '', -- Text to show to identify the alternate file
          directory =  '',     -- Text to show when the buffer is a directory
        },
      },
    },
    lualine_b = {
      'branch',
      'diff',
      'diagnostics',
    },
    lualine_c = {},
    lualine_x = {{
        noice.api.status.search.get,
        cond = noice.api.status.search.has,
        color = { fg = "#ff9e64" },
      },
      'encoding',
      'fileformat',
    },
    lualine_y = {'progress'},
    lualine_z = {progress_bar}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
