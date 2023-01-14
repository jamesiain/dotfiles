local ok, ccc = pcall(require, "ccc")

if not ok then
  return
end

ccc.setup {
  highlighter = {
    auto_enable = true,
  },
}

local set = vim.keymap.set

set("n", "<leader>cc", "<CMD>CccPick<CR>", { desc = "CCC: Pick [C]olor [C]ode" })
