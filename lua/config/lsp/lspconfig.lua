-- Set up lspconfig
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local language_servers = lspconfig.util.available_servers()
for _, ls in ipairs(language_servers) do
  lspconfig[ls].setup({
    capabilities = capabilities
  })
end

-- langservers
local langservers = {
  'html',
  'cssls',
  'cssmodules_ls',
  'unocss',
  'phpactor',
  'intelephense',
  'tsserver',
  'pylsp',
  'lua_ls',
  'vimls'
}

for _, server in ipairs(langservers) do
  lspconfig[server].setup {
    capabilities = capabilities,
  }
end

lspconfig.emmet_ls.setup {
  capabilities = capabilities,
  filetypes = {
    "css",
    "php",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue"
  },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  }
}

-- Set up signs
local signs = { Error = "󰅙 ", Warn = " ", Hint = "󰌵", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
