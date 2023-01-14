local api = vim.api
local nvim_ex = api.nvim_create_augroup("NeoVimEx", { clear = true })

-- when editing a file, always jump to the last known cursor position
-- except when editing Git commit messages, when the position is invalid, or
-- when inside an event handler (which happens when a file is dropped into gvim)
api.nvim_create_autocmd("BufReadPost", {
  group = nvim_ex,
  pattern = "*",
  command = [[
    if &ft != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$")
      execute "normal! g`\""
    endif
  ]],
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
