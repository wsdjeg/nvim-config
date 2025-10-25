return {
    'wsdjeg/format.nvim',
    opts = {
        custom_formatters = {
            lua = {
                exe = 'stylua',
                args = { '-' },
                stdin = true,
            },
        },
    },
    keys = {
        {
            'n',
            '<leader>bf',
            '<cmd>Format<cr>',
            { silent = true },
            desc = 'format current buffer',
        },
        {
            'n',
            '<leader>lf',
            function()
                local cf = vim.call('context_filetype#get')
                if vim.o.filetype == 'markdown' and cf.filetype ~= 'markdown' then
                    local line1 = cf['range'][1][1]
                    local line2 = cf['range'][2][1]
                    vim.cmd(string.format('%s,%sFormat! %s', line1, line2, cf.filetype))
                end
            end,
            { silent = true },
            desc = 'format code block',
        },
    },
    cmds = { 'Format', 'FormatWrite' },
    depends = { { 'Shougo/context_filetype.vim' } },
}
