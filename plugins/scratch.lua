return {
    'wsdjeg/scratch.nvim',
    dev = true,
    keys = {
        {
            'n',
            '<leader>bs',
            function()
                require('scratch').create({})
            end,
            { silent = true },
        },
        {
            'n',
            '<leader>bS',
            function()
                if vim.o.buftype == '' then
                    require('scratch').create({ nofile = true, filetype = vim.o.filetype })
                else
                    require('scratch').create({ nofile = true })
                end
            end,
            { silent = true },
        },
    },
    opts = {
        directory = 'D:/scratch',
    },
}
