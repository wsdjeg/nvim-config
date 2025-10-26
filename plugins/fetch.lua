-- a list of fetch repos

return {
    {
        'wsdjeg/job.nvim',
        fetch = true,
    },
    {
        'wsdjeg/nvim-plug',
        fetch = true,
    },
    {
        'sbdchd/neoformat',
        fetch = true,
    },
    {
        'wsdjeg/keymap-guide.nvim',
        fetch = true,
    },
    {
        'wsdjeg/plugin-utils.nvim',
        fetch = true,
    },
    -- 一些常用仓库，让 nvim-plug 帮我下载并更新，但不加入 vim 插件列表。
    { 'neovim/neovim', fetch = true },
    { 'vim/vim', fetch = true },
    { 'wsdjeg/SpaceVim', fetch = true },
}
