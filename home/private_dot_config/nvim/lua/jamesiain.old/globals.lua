local g = vim.g
local utils = require "jamesiain/utils"

-- custom variables
g.is_lnx = (utils.has "unix" and not utils.has "macunix") and true or false
g.is_mac = (utils.has "macunix") and true or false
g.is_win = (utils.has "win32" or utils.has "win64") and true or false
g.is_wsl = (os.getenv "WSL_DISTRO_NAME") and true or false

-- custom <leader> settings
g.mapleader = " "
g.maplocalleader = "\\"

-- disable the default behavior of the new <leader> key
vim.keymap.set({ "n", "v" }, "<Space>", "<NOP>", { silent = true })

-- integrate with system clipboard
if (g.is_wsl or g.is_win) and utils.executable "win32yank.exe" then
  g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = { "win32yank.exe", "-i", "--crlf" },
      ["*"] = { "win32yank.exe", "-i", "--crlf" },
    },
    paste = {
      ["+"] = { "win32yank.exe", "-o", "--lf" },
      ["*"] = { "win32yank.exe", "-o", "--lf" },
    },
    cache_enabled = false,
  }
end
