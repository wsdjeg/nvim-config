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
    },
    opts = {
        directory = 'D:/scratch',
    },
}
