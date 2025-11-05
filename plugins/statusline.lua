return {
    'wsdjeg/statusline.nvim',
    events = { 'VimEnter' },
    config = function()
        require('statusline').register_sections('vcs', function()
            return '%{ v:lua.require("git.command.branch").current() .. v:lua.require("git.command.pull").status() .. v:lua.require("git.command.push").status() }'
        end)
        require('statusline').setup({
            left_sections = { 'winnr', 'filename', 'vcs' },
            right_sections = { 'fileformat','fileencoding' , 'cursorpos' },
            separator = 'curve',
            iseparator = 'curve',
        })
        for i = 1, 9 do
            vim.keymap.set(
                'n',
                '<leader>' .. i,
                '<cmd>exe "' .. i .. 'wincmd w"<cr>',
                { silent = true }
            )
        end
    end,
    desc = 'module statusline',
    dev = true,
}
