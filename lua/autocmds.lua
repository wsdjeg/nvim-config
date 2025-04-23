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
local imselect = 'C:\\Users\\wsdjeg\\Downloads\\im-select-mspy.exe'

local function imselect_cn()
    vim.system({ imselect, '-k=ctrl+space', '中文模式' })
end

local function imselect_en()
    vim.system({ imselect, '-k=ctrl+space', '英语模式' })
end

local insert_im
create_autocmd({ 'InsertLeave' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        insert_im = vim.fn.trim(vim.fn.system(imselect))
        vim.system({ imselect }, { text = true }, function(o)
            insert_im = vim.trim(vim.iconv(o.stdout, 'cp936', 'utf-8'))
        end)
        imselect_en()
    end,
})
create_autocmd({ 'InsertEnter' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
            local c = '英语模式'
        if insert_im and insert_im ~= '英语模式' then
            vim.system({ imselect, '-k=ctrl+space', insert_im })
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
