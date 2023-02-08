local ok, zen_mode = pcall(require, "zen-mode")

if not ok then
  return
end

zen_mode.setup()

local set = vim.keymap.set

set("n", "<leader>tz", zen_mode.toggle, { desc = "[T]oggle [Z]en Mode" })
