vim.g.completeopt = "menu,menuone,noselect,noinsert"

-- protected call for calling plugin
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--   פּ ﯟ   some other good icons
local icons = {
  Text = "",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  -- Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",

  nvim_lsp = "",
  vsnip = "󰏢",
  buffer = "󱂬"
}

-- highlight color for icons
local hl = vim.api.nvim_set_hl
hl(0, "CmpItemKindText", { fg = "#E65358" })
hl(0, "CmpItemKindKeyword", { fg = "#00FF00" })
hl(0, "CmpItemKindModule", { fg = "#3494EC" })
hl(0, "CmpItemKindProperty", { fg = "#3494EC" })

-- Set up nvim-cmp
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      local default_icon = "" -- Set a default icon for unknown sources

      vim_item.menu = " " .. (entry.source.name or "Unknown") .. " " .. (icons[entry.source.name] or default_icon)

      local sources = {
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "vsnip" },
        { name = "buffer" },
        { name = "path" },
      }

      for _, source in ipairs(sources) do
        source.display_name = source.name .. " " .. (icons[source.name] or default_icon)
      end

      if sources == "vsnip" or sources == "nvim_lsp" then
        vim_item.dup = 0
      end

      function trim(text)
        local max = 40
        if text and text:len() > max then
          text = text:sub(1, max) .. "···"
        end
        return text
      end

      vim_item.abbr = trim(vim_item.abbr)
      return vim_item

    end,
  },
  sources = {
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "vsnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      side_padding = 0,
      col_offset = -3,
    }
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
})

-- Set configuration for specific filetypes
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  }),
})

-- Use buffer source for '/', '?', ':'
cmp.setup.cmdline({ '/', '?', ':' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

vim.cmd("autocmd ColorScheme * highlight Pmenu guibg=NONE")
vim.opt.pumblend = 0
