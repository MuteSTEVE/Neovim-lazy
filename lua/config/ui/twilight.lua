local status_ok, twilight = pcall(require, 'twilight')
if not status_ok then
  return 
end

twilight.setup({
  dimming = {
    alpha = 0.25,
    color = { "Normal", "#ffffff" },
    term_bg = "#000000",
    inactive = false,
  },
  context = 10,
  treesitter = true,
  expand = { "function", "method", "table", "if_statement" },
  exclude = {} -- exclude these filetypes
})
