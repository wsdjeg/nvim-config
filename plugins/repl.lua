return {
    'wsdjeg/repl.nvim',
    config = function()
        require('repl').setup({ executables = { lua = 'lua', python = 'python' } })
        vim.keymap.set(
            'n',
            '<leader>lsi',
            '<cmd>lua require("repl").start(vim.o.filetype)<cr>',
            { silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>lsl',
            '<cmd>lua require("repl").send("line")<cr>',
            { silent = true }
        )
    end,
    type = 'rocks',
    on_map = { '<leader>lsl', '<leader>lsi' },
    dev = true,
    desc = 'repl support for neovim',
}
