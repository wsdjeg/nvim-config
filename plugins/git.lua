return {
    'wsdjeg/git.nvim',
    keys = {
        {
            'n',
            '<leader>gs',
            '<cmd>Git status<cr>',
            { silent = true, desc = 'display git status' },
        },
        { 'n', '<leader>gA', '<cmd>Git add .<cr>', { silent = true, desc = 'git add all files' } },
        { 'n', '<leader>gc', '<cmd>Git commit<cr>', { silent = true, desc = 'git commit' } },
        { 'n', '<leader>gv', '<cmd>Git log --decorate --branches<cr>', { silent = true, desc = 'git log of project' } },
        {
            'n',
            '<leader>gV',
            '<cmd>Git log %<cr>',
            { silent = true, desc = 'git log of current file' },
        },
        { 'n', '<leader>gp', '<cmd>Git push<cr>', { silent = true, desc = 'git push' } },
        { 'n', '<leader>gd', '<cmd>Git diff<cr>', { silent = true, desc = 'git diff' } },
        { 'n', '<leader>gb', '<cmd>Git branch<cr>', { silent = true, desc = 'git diff' } },
    },
    desc = 'git integration in neovim',
    dev = true,
}
