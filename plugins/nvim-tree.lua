return {
    'nvim-tree/nvim-tree.lua',
    config_before = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.keymap.set('n', '<F3>', '<cmd>NvimTreeToggle<cr>', { silent = true })
        vim.keymap.set('n', '<leader>fo', function()
            local ok, api = pcall(require, 'nvim-tree.api')
            if ok then
                api.tree.change_root(vim.fn.getcwd())
                api.tree.open({
                    find_file = true,
                })
            else
                vim.cmd('NvimTreeFindFile')
            end
        end, { silent = true })
    end,
    config = function()
        require('nvim-tree').setup({
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
        })
    end,
    cmds = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile' },
    depends = {
        { 'nvim-tree/nvim-web-devicons' },
    },
}
