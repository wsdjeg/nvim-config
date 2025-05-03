local augroup = vim.api.nvim_create_augroup('wsdjeg', { clear = true })

local create_autocmd = vim.api.nvim_create_autocmd
create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
        require('mkdir').create_current()
    end,
})

-- download im-select-mspy from https://github.com/daipeihust/im-select/raw/refs/heads/master/win-mspy/out/x64/im-select-mspy.exe
local imselect = 'C:\\Users\\wsdjeg\\Downloads\\im-select-mspy.exe'

local function imselect_cn()
    vim.system({ imselect, '-k=ctrl+space', '中文模式' })
end

local function imselect_en()
    vim.system({ imselect, '-k=ctrl+space', '英语模式' })
end

local buffer_im = {}

create_autocmd({ 'InsertLeave' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(ev)
        vim.system({ imselect }, { text = true }, function(o)
            -- 这里说明下，再 Windows Terminal 内执行该命令输出的内容默认编码是 `cp936`,
            -- 需要转码成 utf-8，同时，输出内容尾部有换行符，使用 trim 函数去除。
            buffer_im[ev.buf] = vim.trim(vim.iconv(o.stdout, 'cp936', 'utf-8'))
        end)
        imselect_en()
    end,
})
create_autocmd({ 'InsertEnter' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(ev)
            local c = '英语模式'
        if buffer_im[ev.buf] and buffer_im[ev.buf] ~= '英语模式' then
            -- 此处设置快捷键，可以在输入法按键设置里面查看，我选择的是使用 ctrl-space 切换中英文
            -- 默认我记得是 shift，同时这个命令默认也是 `-k=shift`
            vim.system({ imselect, '-k=ctrl+space', buffer_im[ev.buf] })
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

create_autocmd({'InsertLeave'}, {
    pattern = {'*'},
    group = augroup,
    callback = function(_)
        vim.wo.cursorline = true
    end
})
create_autocmd({'InsertEnter'}, {
    pattern = {'*'},
    group = augroup,
    callback = function(_)
        vim.wo.cursorline = false
    end
})
