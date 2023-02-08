local api = vim.api
local nvim_ex = api.nvim_create_augroup("NeoVimEx", { clear = true })

-- when editing a file, jump to the last known cursor position (in most cases)
api.nvim_create_autocmd("BufReadPost", {
  group = nvim_ex,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "gitcommit" then
      return -- always start Git commits with cursor at line 0
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

local nvim_hl = api.nvim_create_augroup("NeoVimHighlight", { clear = true })

-- flash the highlight briefly on the region which is yanked
api.nvim_create_autocmd("TextYankPost", {
  group = nvim_hl,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
