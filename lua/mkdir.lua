local M = {}

local function mkdir(dir)
  vim.fn.mkdir(dir, 'p')
end

local function create_directory(dir)
  if vim.regex('^[a-z]\\+:/'):match_str(dir) then
    return
  end
  if vim.fn.isdirectory(dir) == 0 then
    mkdir(dir)
  end
end

function M.create_current()
  local dir = vim.fn.fnamemodify(vim.fn.expand('<afile>'), ':p:h')
  create_directory(dir)
end

return M
