local ok, persist_colorscheme = pcall(require, "colorscheme-persist")
if not ok then
  return
end

local os_sep = require("plenary.path").path.sep
local set = vim.keymap.set

persist_colorscheme.setup {
  file_path = vim.fn.stdpath "state" .. os_sep .. "colorscheme-persist.lua",
  fallback = "lunaperche", -- least offensive built-in colorscheme
  disable = { -- do not include built-in colorschemes in picker
    "blue",
    "darkblue",
    "default",
    "delek",
    "desert",
    "elflord",
    "evening",
    "habamax",
    "industry",
    "koehler",
    "morning",
    "murphy",
    "pablo",
    "peachpuff",
    "quiet",
    "ron",
    "shine",
    "slate",
    "torte",
    "zellner",
  },
  enable_preview = true,
}

-- Get stored colorscheme (or default)
local colorscheme = persist_colorscheme.get_colorscheme()

-- Set colorscheme with previously stored value
vim.cmd("colorscheme " .. colorscheme)

-- Keymap for telescope selection
set("n", "<leader>cs", require("colorscheme-persist").picker, { desc = "Select [C]olor[s]cheme" })
