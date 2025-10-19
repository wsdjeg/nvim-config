return {
    'wsdjeg/music-player.nvim',
    opts = {
        musics_directory = 'D:\\wsdjeg\\my-blog\\docs\\musics',
    },
    keys = {
        {
            'n',
            '<leader>ms',
            '<cmd>lua require("music-player").stop()<cr>',
            { silent = true, desc = 'stop musics player' },
        },
        {
            'n',
            '<leader>mf',
            '<cmd>Picker music-player<cr>',
            { silent = true, desc = 'fuzzy find music' },
        },
    },
    on_map = {'<leader>ms', '<leader>mf'},
    dev = true,
}
