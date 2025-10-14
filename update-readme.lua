local M = {}

M.begin = '^<!-- nvim-config doc start -->$'
M._end = '^<!-- nvim-config doc end -->$'
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
        if v.fetch and v.name ~= 'nvim-plug' and v.name ~= 'job.nvim' then
            goto continue
        end
        table.insert(lines, '')
        if v.desc then
            table.insert(lines, '- ' .. v.desc .. ': [' .. v.name .. '](' .. v.url .. ')')
        else
            table.insert(lines, '- [' .. v.name .. '](' .. v.url .. ')')
        end
        if v.keys then
            table.insert(lines, '')
            table.insert(lines, '| key binding | description |')
            table.insert(lines, '| --- | --- |')
            for _, key in ipairs(v.keys) do
                table.insert(
                    lines,
                    '| `' .. table.concat(key[2], '` ') .. ' | ' .. key.desc .. ' |'
                )
            end
        end
        ::continue::
    end
    return lines
end

M.content_func = generate_content

M.update()
