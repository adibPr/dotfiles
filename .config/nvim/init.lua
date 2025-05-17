require("config.lazy")

-- Basic options
vim.opt.compatible = false
vim.opt.wrap = false
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.sessionoptions = { "tabpages" }
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldignore = ""
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.mouse = ""
vim.opt.hlsearch = true
vim.opt.encoding = "utf-8"
vim.opt.colorcolumn = "80"

-- Set colorscheme (if available)
vim.cmd("colorscheme retrobox")

-- Highlight settings
vim.cmd("highlight Normal ctermbg=none")
vim.cmd("highlight NonText ctermbg=none")

-- Filetype detection
vim.cmd([[
  filetype on
  filetype plugin on
  filetype indent on
]])


-- Key mappings
vim.keymap.set("v", "//", 'y/<C-R>"<CR>', { noremap = true })
vim.keymap.set("n", "<space>", "za", { noremap = true })
vim.keymap.set("v", "<space>", "zf", { noremap = true })
vim.keymap.set("n", "<C-n>", "gt", { noremap = true })
vim.keymap.set("n", "<C-p>", "gT", { noremap = true })

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Airline configuration (if used manually or plugin respects global vars)
vim.g.airline_powerline_fonts = 0
vim.g.airline_theme = "base16"
vim.g.airline_symbols_ascii = 1
