return {
    'wsdjeg/rooter.nvim',
    opts = {
        root_pattern = { '.git/' },
        enable_logger = true,
    },
    keys = {
        {
            'n',
            '<leader>fp',
            '<cmd>Picker project<cr>',
            { silent = true, desc = 'fuzzy find recent project' },
        },
    },
    dev = true,
    type = 'rocks',
    desc = 'Changes Neovim working directory to project root.',
}
