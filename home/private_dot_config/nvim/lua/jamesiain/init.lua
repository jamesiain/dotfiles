vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require "jamesiain.lazy"

local ok, persist_colorscheme = pcall(require, "colorscheme-persist")
if not ok then
  return
end

-- Get stored colorscheme (or default)
local colorscheme = persist_colorscheme.get_colorscheme()

-- Set colorscheme with previously stored value
vim.cmd("colorscheme " .. colorscheme)

