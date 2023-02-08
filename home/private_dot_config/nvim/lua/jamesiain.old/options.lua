local opt = vim.opt

opt.encoding = "utf-8"
opt.termguicolors = true

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.autowrite = true -- automatically :write before running commands
opt.modelines = 0 -- disable modelines as a security precaution
opt.modeline = false
opt.showmode = false -- lualine plugin replaces this feature

local indent = 2

opt.tabstop = indent
opt.shiftwidth = indent
opt.shiftround = true
opt.expandtab = true

opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

opt.list = true
opt.listchars = "tab:»·,trail:·,nbsp:␣"

opt.textwidth = 80
opt.colorcolumn = "+1" -- make it obvious where the column at textwidth is

opt.number = true -- show line numbers in left gutter
opt.numberwidth = 5
opt.relativenumber = true -- most line numbers are relative to current line
opt.cursorline = true -- highlight the current horizontal line

opt.splitbelow = true -- open new split panes below the current one
opt.splitright = true -- open new vsplit panes to the right

opt.clipboard = "unnamedplus"
