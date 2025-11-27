return {
    'wsdjeg/hop.nvim',
    keys = {
        { 'n', '<leader>jl', '<cmd>HopLine<cr>', { silent = true, desc = 'hop jump line' } },
        { 'n', '<leader>jj', '<cmd>HopChar1<cr>', { silent = true, desc = 'hop jump char' } },
        { 'n', '<leader>j/', '<cmd>HopPattern<cr>', { silent = true, desc = 'hop jump pattern' } },
    },
    cmds = { 'HopPattern', 'HopLine', 'HopChar1' },
    opts = { match_mappings = { 'zh', 'zh_sc' } },
    type = 'rocks',
    dev = true,
    desc = 'forked hop',
}
