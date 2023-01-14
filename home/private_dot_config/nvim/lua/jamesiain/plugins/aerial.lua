local ok, aerial = pcall(require, "aerial")

if not ok then
  return
end

aerial.setup()

local set = vim.keymap.set

set("n", "<leader>ta", "<CMD>AerialToggle!<CR>", { desc = "[T]oggle [A]erial Code Outline" })
