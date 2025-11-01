return {
    'nvim-tree/nvim-tree.lua',
    config_before = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        local augroup = vim.api.nvim_create_augroup('eric-nvim-tree', {clear = true})
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            group = augroup,
            pattern = { 'NvimTree' },
            callback = function(ev)
                vim.keymap.set('n', '<F2>', '<Nop>', {
                    buffer = ev.buf,
                })
            end,
        })
    end,
    module = 'nvim-tree',
    keys = {
        { 'n', '<F3>', '<cmd>NvimTreeToggle<cr>', { silent = true, desc = 'toggle file tree' } },
        {
            'n',
            '<leader>fo',
            function()
                local ok, api = pcall(require, 'nvim-tree.api')
                if ok then
                    api.tree.change_root(vim.fn.getcwd())
                    api.tree.open({
                        find_file = true,
                    })
                else
                    vim.cmd('NvimTreeFindFile')
                end
            end,
            { silent = true },
        },
    },
    opts = {
        hijack_cursor = true,
        sort = {
            sorter = 'case_sensitive',
        },
        view = {
            width = 35,
            side = 'right',
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    },
    cmds = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile' },
    depends = {
        { 'nvim-tree/nvim-web-devicons' },
    },
}
