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
            { silent = true },
        },
        {
            'n',
            '<leader>mf',
            '<cmd>Telescope music-player<cr>',
            { silent = true },
        },
    },
    dev = true,
}
