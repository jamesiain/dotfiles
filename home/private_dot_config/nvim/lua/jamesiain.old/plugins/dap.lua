local ok, dap = pcall(require, "dap")

if not ok then
  return
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running NeoVim instance",
  },
}

dap.adapters.nlua = function(callback, config)
  callback({
    type = "server",
    host = config.host or "127.0.0.1",
    port = config.port or 8086,
  })
end

local set = vim.keymap.set

set("n", "<F8>", [[:lua require"dap".toggle_breakpoint()<CR>]], { desc = "DAP: Toggle breakpoint" })
set("n", "<F9>", [[:lua require"dap".continue()<CR>]], { desc = "DAP: Continue" })
set("n", "<F10>", [[:lua require"dap".step_over()<CR>]], { desc = "DAP: Step over" })
set("n", "<S-F10>", [[:lua require"dap".step_into()<CR>]], { desc = "DAP: Step into" })
set("n", "<F12>", [[:lua require"dap.ui.widgets".hover()<CR>]], { desc = "DAP: Trigger hover" })
set("n", "<F5>", [[:lua require"osv".launch({port = 8086})<CR>]], { desc = "DAP: Launch" })
