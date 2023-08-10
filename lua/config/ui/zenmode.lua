local status_ok, zen = pcall(require, 'zen-mode')
if not status_ok then
  return 
end

zen.setup {
  window = {
    backdrop = 0.95,
    width = 100,
    height = 0.8,
    -- options = {signcolumn = "no", number = false, cursorline = false}
  },
  plugins = {
    options = {enabled = true, ruler = false, showcmd = false},
    twilight = {enabled = true},
    gitsigns = {enabled = false},
    tmux = {enabled = false}
  }
}
