local keys = {}
for i = 1, 9, 1 do
    table.insert(keys, {
        'n',
        '\\' .. i,
        function()
            require('tabline').jump(i)
        end,
        { silent = true, desc = string.format('jump to tab %d', i) },
    })
end
return {
    'wsdjeg/tabline.nvim',
    events = { 'VimEnter' },
    opts = {
        show_index = true,
        separator = 'curve',
        iseparator = 'curve',
    },
    keys = keys,
    dev = true,
}
