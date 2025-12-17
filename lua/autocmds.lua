local augroup = vim.api.nvim_create_augroup('wsdjeg', { clear = true })

local create_autocmd = vim.api.nvim_create_autocmd
create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        require('mkdir').create_current()
    end,
})
create_autocmd({ 'InsertLeave' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        vim.wo.cursorline = true
    end,
})
create_autocmd({ 'InsertEnter' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        vim.wo.cursorline = false
    end,
})
