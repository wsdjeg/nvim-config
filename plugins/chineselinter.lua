return {
    'wsdjeg/chineselinter.nvim',
    dev = true,
    opts = {
        ignored_errors = { 'E015', 'E013', 'E020', 'E021' },
    },
    cmds = { 'CheckChinese' },
    desc = 'Chinese Document Language Standards Checking Tool',
}
