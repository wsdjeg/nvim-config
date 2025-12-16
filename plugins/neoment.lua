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
                invite = '', -- Icon for room invites
                buffer = '󰮫', -- Icon for buffer rooms
                favorite = '', -- Icon for favorite rooms
                people = '', -- Icon for people/DMs
                space = '󰴖', -- Icon for spaces
                room = '󰮧', -- Icon for regular rooms
                low_priority = '󰘄', -- Icon for low priority rooms
                reply = '↳', -- Icon for message replies
                right_arrow = '▶', -- Icon for collapsed sections
                down_arrow = '▼', -- Icon for expanded sections
                down_arrow_circle = '', -- Icon for down arrow in circle
                bell = '󰵛', -- Icon for mentions/highlights
                dot = '•', -- Icon for unread indicator
                dot_circle = '', -- Icon for dot in circle
                border_left = '', -- Icon for left border
                border_right = '', -- Icon for right border
                vertical_bar = '│', -- Icon for vertical separator
                vertical_bar_thick = '┃', -- Icon for thick vertical separator
                tree_branch = '├', -- Icon for tree branch
                image = '󰋩', -- Icon for images
                file = '󰈙', -- Icon for files
                audio = '', -- Icon for audio files
                location = '󰍎', -- Icon for location
                video = '', -- Icon for video files
            },
        }
    end,
    dev = true,
    desc = 'matrix client for neovim',
}
