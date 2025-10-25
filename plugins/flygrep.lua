return {
    'wsdjeg/flygrep.nvim',
    cmds = { 'FlyGrep', 'FlyGrepCword' },
    config = function()
        require('flygrep').setup({
            timeout = 200,
            color_templete = {
                a = {
                    fg = '#2c323c',
                    bg = '#98c379',
                    ctermfg = 16,
                    ctermbg = 114,
                    bold = true,
                },
                b = {
                    fg = '#abb2bf',
                    bg = '#3b4048',
                    ctermfg = 145,
                    ctermbg = 16,
                    bold = false,
                },
            },

            command = {
                execute = 'rg',
                default_opts = {
                    '--no-heading',
                    '--color=never',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '-g',
                    '!.git',
                },
                expr_opt = '-e',
                fixed_string_opt = '-F',
                default_fopts = { '-N' },
                smart_case = '-S',
                ignore_case = '-i',
                hidden_opt = '--hidden',
            },

            matched_higroup = 'IncSearch',

            enable_preview = false,
            window = {
                width = 0.9,
                height = 0.9,
                col = 0.05,
                row = 0.05,
            },
        })
        vim.api.nvim_create_user_command('FlyGrepCword', function(opt)
            require('flygrep').open({ input = vim.fn.expand('<cword>') })
        end, { nargs = '*' })
    end,
    keys = {
        {
            'n',
            '<leader>s/',
            '<cmd>FlyGrep<cr>',
            { silent = true, desc = 'open flygrep' },
        },
        {
            'n',
            '<leader>sp',
            '<cmd>FlyGrepCword<cr>',
            { silent = true, desc = 'open flygrep with cursor word' },
        },
    },
    desc = 'grep on the fly',
}
