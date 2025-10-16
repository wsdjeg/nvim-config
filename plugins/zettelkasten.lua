return {
    'wsdjeg/vim-zettelkasten',
    config_before = function()
        vim.g.zettelkasten_directory = 'D:/wsdjeg/my-blog/zettelkasten'
        vim.g.zettelkasten_template_directory = 'D:/wsdjeg/my-blog/zettelkasten_template'
    end,
    keys = {
        {
            'n',
            '<leader>zb',
            '<cmd>ZkBrowse<cr>',
            { silent = true, desc = 'open zettelkasten browse' },
        },
        {
            'n',
            '<leader>zn',
            '<cmd>ZkNew<cr>',
            { silent = true, desc = 'create new zettelkasten note' },
        },
        {
            'n',
            '<leader>zf',
            '<cmd>Picker zettelkasten<cr>',
            { silent = true, desc = 'fuzzy find zettelkasten notes' },
        },
        {
            'n',
            '<leader>zt',
            '<cmd>Picker zettelkasten_tags<cr>',
            { silent = true, desc = 'fuzzy find zettelkasten tags' },
        },
    },
    dev = true,
}
