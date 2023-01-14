local set = vim.keymap.set

-- quicker window movement
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-h>", "<C-w>h")
set("n", "<C-l>", "<C-w>l")

-- diagnostics
set("n", "[d", vim.diagnostic.goto_prev)
set("n", "]d", vim.diagnostic.goto_next)
set("n", "<leader>e", vim.diagnostic.open_float)
set("n", "<leader>q", vim.diagnostic.setloclist)
