-- a list of fetch repos

return {
    {
        'wsdjeg/job.nvim',
        fetch = true,
        desc = 'neovim job api',
    },
    {
        'wsdjeg/nvim-plug',
        fetch = true,
        desc = 'neovim plugin manager',
    },
    {
        'sbdchd/neoformat',
        fetch = true,
    },
    {
        'wsdjeg/keymap-guide.nvim',
        fetch = true,
        desc = 'floating key binding guide',
    },
    {
        'wsdjeg/utils.nvim',
        fetch = true,
        desc = 'A collection of useful utilities for neovim.',
    },
    -- 一些常用仓库，让 nvim-plug 帮我下载并更新，但不加入 vim 插件列表。
    { 'neovim/neovim', fetch = true },
    { 'vim/vim', fetch = true },
    { 'wsdjeg/SpaceVim', fetch = true, desc = 'A modular configuration of Vim and Neovim ' },
}
