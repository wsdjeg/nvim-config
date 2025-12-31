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
  local repos = {}
  for _, v in pairs(require('plug').get()) do
    if vim.regex('^wsdjeg/'):match_str(v[1]) and not v.fetch then
      table.insert(repos, v.name)
    end
  end
  local lines = {}
  for _, repo in ipairs(repos) do
    table.insert(lines, '<a href="https://github.com/wsdjeg/' .. repo .. '">')
    table.insert(
      lines,
      '  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo='
        .. repo
        .. '" />'
    )
    table.insert(lines, '</a>')
    table.insert(lines, '')
  end
  return lines
end

M.content_func = generate_content

M.update()
