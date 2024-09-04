-- options
local g = vim.g
local o = vim.o
local opt = vim.opt
local A = vim.api

opt.compatible = false
o.termguicolors = true
-- o.t_Co = 256
o.cursorline = true
o.fileencoding = 'utf-8'
o.background = 'dark'
A.nvim_exec('language en_US', true)
opt.showmode = false

-- numbers
o.number = true
o.relativenumber = true
o.numberwidth = 3

-- editing
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.wrap = false
o.autoindent = true
o.colorcolumn = '80'

-- hightlight search
opt.hlsearch = false
opt.incsearch = true
opt.wrap = true
opt.breakindent = true

opt.scrolloff = 50
opt.signcolumn = "yes"

-- undo and backup
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 250

-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- minimap
g.minimap_left = 1

-- REPL
g.repl_split = 'bottom'
g.repl_height = 15

-- markdown preview
g.mkdp_auto_start = 1

-- neovide setting
A.nvim_command(
  "let g:neovide_hide_mouse_when_typing = v:true"
)
