local M = {}

M.begin = '^<!-- wsdjeg repos start -->$'
M._end = '^<!-- wsdjeg repos end -->$'
M.content_func = ''
M.autoformat = 0

function M._find_position()
  local start = vim.fn.search(M.begin, 'bwnc')
  local _end = vim.fn.search(M._end, 'bnwc')
  return unpack(vim.fn.sort({ start, _end }, 'n'))
end

function M.update(...)
  local start, _end = M._find_position()
  if start ~= 0 and _end ~= 0 then
    if _end - start > 1 then
      vim.cmd((start + 1) .. ',' .. (_end - 1) .. 'delete')
    end
    vim.fn.append(start, M.content_func())
  end
end

local function generate_content()
  local lines = {}
  for _, v in pairs(require('plug').get()) do
    local l = '- [' .. v[1] .. '](https://github.com/' .. v[1] .. ')'
    if v.desc then
        l = l .. ': ' .. v.desc
    end
    table.insert(lines, l)
  end
  return lines
end

M.content_func = generate_content

M.update()
