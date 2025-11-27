return {
    'wsdjeg/format.nvim',
    opts = {
        custom_formatters = {
            lua = {
                exe = 'stylua',
                args = { '-' },
                stdin = true,
            },
            javascript = {
                exe = 'clang-format',
                stdin = true,
                args = { '-assume-filename=t.js' },
            },
        },
    },
    keys = {
        {
            'n',
            '<leader>bf',
            '<cmd>Format<cr>',
            { desc = 'format current buffer', silent = true },
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
            { desc = 'format code block', silent = true },
        },
    },
    cmds = { 'Format', 'FormatWrite' },
    depends = { { 'Shougo/context_filetype.vim' } },
    type = 'rocks',
    desc = 'asynchronous code formatting plugin for neovim',
}
