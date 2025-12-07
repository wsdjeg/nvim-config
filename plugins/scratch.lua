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
                require('scratch').create({ nofile = true, filetype = vim.b.filetype })
            end,
            { silent = true },
        },
    },
    opts = {
        directory = 'D:/scratch',
    },
}
