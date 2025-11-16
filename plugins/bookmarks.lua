return {
    'wsdjeg/bookmarks.nvim',
    config_before = function()
        vim.keymap.set('n', 'mm', '<Plug>(bookmarksToggle)', { noremap = false })
        vim.keymap.set('n', 'mi', '<Plug>(bookmarksAnnotation)', { noremap = false })
        vim.keymap.set('n', 'mn', '<Plug>(bookmarksNext)', { noremap = false })
        vim.keymap.set('n', 'mc', '<Plug>(bookmarksClear)', { noremap = false })
        vim.keymap.set('n', 'ma', '<Plug>(bookmarksListAll)', { noremap = false })
        vim.keymap.set('n', 'mp', '<Plug>(bookmarksPrevious)', { noremap = false })
        vim.keymap.set('n', '<leader>fb', '<Plug>(bookmarksPickerAll)', { noremap = false })
    end,
    config = function()
        ---  this must be called after on_map lazy
        vim.keymap.set('n', '<Plug>(bookmarksPickerAll)', '', {
            callback = function()
                vim.cmd('Picker bookmarks')
            end,
            noremap = true,
        })
    end,
    opts = {
        sign_text = '⚑',
    },
    on_map = { '<Plug>(bookmarks' },
    dev = true,
    desc = 'bookmarks manager for neovim'
}
