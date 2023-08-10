local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local status_ok, fortune = pcall(require, 'alpha.fortune')
if not status_ok then
  return
end

local status_ok, dashboard = pcall(require, 'alpha.themes.dashboard')
if not status_ok then
  return
end

local logo = [[
   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ 
   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ 
   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ 
   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ 
   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
]]

local function getGreeting(name)
  local tableTime = os.date("*t")
  local datetime = os.date("  %Y-%m-%d   %H:%M")
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = "  Turu'",
    [2] = "  おはよう",
    [3] = "  こんにちは",
    [4] = "  こんにちは",
    [5] = "󰖔  おやすみ",
  }
  local greetingIndex = 0
  if hour == 23 or hour < 7 then
    greetingIndex = 1
  elseif hour < 12 then
    greetingIndex = 2
  elseif hour >= 12 and hour < 18 then
    greetingIndex = 3
  elseif hour >= 18 and hour < 21 then
    greetingIndex = 4
  elseif hour >= 21 then
    greetingIndex = 5
  end
  return "\t" .. datetime .. "\t" .. greetingsTable[greetingIndex] .. " " .. name
end

local handle = io.popen("whoami")
local result = handle:read("*a")
handle:close()

local userName = result:match("^%s*(.-)%s*$") .. "-sama" .. " :D"
local greeting = getGreeting(userName)

dashboard.section.header.val = vim.split(logo .. "\n" .. greeting, "\n")

dashboard.section.buttons.val = {
	dashboard.button("f", "󰍉  Open file", ":Telescope find_files <CR>"),
	dashboard.button("b", "  Open directory", ":Telescope file_browser <CR>"),
	dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
	-- dashboard.button("s", "  Load session", ":SessionManager load_session<cr>"),
	-- dashboard.button("t", "󰈞  Find text", ":Telescope live_grep <CR>"),
	-- dashboard.button("l", "󰇚  Install LSP", ":Mason <CR>"),
	dashboard.button("q", "󰿅  Quit Neovim", ":qa!<CR>"),
}

-- local function footer()
-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
  -- return [[
  --   Ⓐ  Free and Opensource ☭
  -- ]]
-- end

dashboard.section.footer.val = fortune()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
