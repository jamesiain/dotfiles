local fn = vim.fn

local M = {}

-- check whether a file is executable
function M.executable(name)
  if fn.executable(name) == 1 then
    return true
  end
  return false
end

-- check whether a feature exists in nvim
function M.has(feat)
  if fn.has(feat) == 1 then
    return true
  end
  return false
end

return M
