local augroup = vim.api.nvim_create_augroup('wsdjeg', { clear = true })

local create_autocmd = vim.api.nvim_create_autocmd
create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        require('mkdir').create_current()
    end,
})

local imselect = 'C:\\Users\\wsdjeg\\Downloads\\im-select.exe'

create_autocmd({ 'InsertLeave' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        vim.fn.system(imselect .. ' 1033')
    end,
})
create_autocmd({ 'FocusLost' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        vim.fn.system(imselect .. ' 2052')
    end,
})
create_autocmd({ 'FocusGained' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        vim.fn.system(imselect .. ' 1033')
    end,
})
