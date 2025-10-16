return {
    'wsdjeg/picker.nvim',
    opts = {
        window = { enable_preview = true },
        highlight = {
            matched = 'Tag',
        },
        prompt = {
            position = 'top',
        },
    },
    keys = {
        {
            'n',
            '<C-p>',
            '<cmd>Picker files<cr>',
            { silent = true, desc = 'fuzzy find files in current dir' },
        },
        {
            'n',
            '<leader>fr',
            '<cmd>Picker mru<cr>',
            { silent = true, desc = 'fuzzy find most recent used files' },
        },
        {

            'n',
            '<leader>bb',
            '<cmd>Picker buffers<cr>',
            { silent = true, desc = 'fuzzy find listed buffers' },
        },
        {
            'n',
            '<leader>ji',
            '<cmd>Picker buftags<cr>',
            { silent = true, desc = 'fuzzy find ctags outline' },
        },
        {
            'n',
            '<leader>fl',
            '<cmd>Picker lines<cr>',
            { silent = true, desc = 'fuzzy find lines in current buffer' },
        },
        {
            'n',
            '<leader>ff',
            '<cmd>Picker<cr>',
            { silent = true, desc = 'fuzzy find picker source' },
        },
    },
    dev = true,
}
