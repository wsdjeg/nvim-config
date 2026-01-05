local M = {}

function M.get(year, month)
  local notes = require('zettelkasten.browser').get_notes()
  local marks = {}
  for _, note in ipairs(notes) do
    local t = vim.split(note.id, '-')
    if tonumber(t[1]) == year and tonumber(t[2]) == month then
      table.insert(
        marks,
        { year = tonumber(t[1]), month = tonumber(t[2]), day = tonumber(t[3]) }
      )
    end
  end

  return marks
end

return M
