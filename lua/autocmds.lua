local augroup = vim.api.nvim_create_augroup('wsdjeg', { clear = true })

local create_autocmd = vim.api.nvim_create_autocmd
create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        require('mkdir').create_current()
    end,
})

-- download im-select from https://github.com/daipeihust/im-select
local imselect = 'C:\\Users\\wsdjeg\\Downloads\\im-select.exe'

local function imselect_cn()
    vim.system({ imselect, '2052' })
end

local function imselect_en()
    vim.system({ imselect, '1033' })
end

local insert_im
create_autocmd({ 'InsertLeave' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        insert_im = vim.fn.trim(vim.fn.system(imselect))
        vim.system({ imselect }, { text = true }, function(o)
            insert_im = o.stdout
        end)
        imselect_en()
    end,
})
create_autocmd({ 'InsertEnter' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        if insert_im and insert_im ~= '1033' then
            vim.system({ imselect, insert_im })
        end
    end,
})

create_autocmd({ 'FocusGained', 'CmdlineLeave', 'VimEnter' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        imselect_en()
    end,
})
create_autocmd({ 'FocusLost' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        imselect_cn()
    end,
})
