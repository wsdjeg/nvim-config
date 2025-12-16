return {
    'wsdjeg/neoment',
    depends = { {

        'nvim-lua/plenary.nvim',
    } },
    config = function()
        vim.g.neoment = {
            -- Save session data to disk (default: true)
            save_session = true,

            -- Icon configuration (all optional)
            icon = {
                invite = '',
                buffer = '󰮫',
                favorite = '',
                people = '',
                space = '󰴖',
                room = '󰮧',
                low_priority = '󰘄',
                reply = '↳',
                right_arrow = '▶',
                down_arrow = '▼',
                down_arrow_circle = '',
                bell = '󰵛',
                dot = '•',
                dot_circle = '',
                border_left = '',
                border_right = '',
                vertical_bar = '│',
                vertical_bar_thick = '┃',
                tree_branch = '├',
                image = '󰋩',
                file = '󰈙',
                audio = '',
                location = '󰍎',
                video = '',
            },
        }
    end,
    dev = true,
    desc = 'matrix client for neovim',
}
