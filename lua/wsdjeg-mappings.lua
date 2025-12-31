local M = {}

M.begin = '^<!-- wsdjeg key bindings start -->$'
M._end = '^<!-- wsdjeg key bindings end -->$'
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
  local mappings = {}
  for _, mode in pairs({ 'n' }) do
    for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
      table.insert(mappings, map)
    end
  end
  local lines = { '| 快捷键 | 功能描述 |', '| --- | --- |' }
  for _, map in ipairs(mappings) do
    if map.desc then
      table.insert(
        lines,
        '| `' .. vim.fn.keytrans(map.lhs) .. '` | ' .. map.desc .. ' |'
      )
    end
  end
  return lines
end

M.content_func = generate_content

M.update()
