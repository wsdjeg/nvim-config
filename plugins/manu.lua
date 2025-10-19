return {
    'bassamsdata/namu.nvim',
    opts = {
        -- Enable the modules you want
        namu_symbols = {
            enable = true,
            options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        ui_select = { enable = false }, -- vim.ui.select() wrapper
    },
    key = {
        {
            'n',
            '<leader>ss',
            ':Namu symbols<cr>',
            {
                desc = 'Jump to LSP symbol',
                silent = true,
            },
        },
        {
            'n',
            '<leader>sw',
            ':Namu workspace<cr>',
            {
                desc = 'LSP Symbols - Workspace',
                silent = true,
            },
        },
    },
    events = { 'LspAttach' },
}
