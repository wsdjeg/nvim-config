return {
    'wsdjeg/mru.nvim',
    events = { 'UIEnter' },
    opts = {
        enable_cache = true,
        ignore_path_regexs = {
            '/.git/',
            '/nvim/runtime/doc/',
            '.mp3$',
            '.mp4$',
            '.png$',
            '.jpg$',
            '.exe$',
            'nvim-mru.json$',
            'tags$',
        },
        enable_logger = true,
        sort_by = 'lastenter',
    },
    dev = true,
    desc = 'mru(most recently used) files',
}
