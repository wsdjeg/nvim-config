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
table.insert(keys, {
    'n',
    '<leader>bn',
    function()
        require('tabline').jump('next')
    end,
    { silent = true, desc = 'jump to next item' },
})
table.insert(keys, {
    'n',
    '<leader>bp',
    function()
        require('tabline').jump('prev')
    end,
    { silent = true, desc = 'jump to previous item' },
})
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
