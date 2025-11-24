return {
    'wsdjeg/terminal.nvim',
    keys = {
        {
            'n',
            "<leader>'",
            '<cmd>lua require("terminal").open()<cr>',
            { silent = true, desc = 'open terminal in current path' },
        },
        {
            'n',
            '<leader>"',
            '<cmd>lua require("terminal").open(vim.fn.expand("%:p:h"))<cr>',
            { silent = true, desc = 'open terminal in file path' },
        },
    },
    opts = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    dev = true,
    desc = 'simple floating terminal plugin for Neovim',
}
