return {
    'wsdjeg/neoment',
    depends = { {

        'nvim-lua/plenary.nvim',
    } },
    config = function()
        local nt = require('neoment.notify')
        local notify = require('notify')
        nt.info = function(msg)
            notify.notify(msg)
        end
        nt.warning = function(msg)
            notify.notify(msg, 'WarningMsg')
        end
        nt.error = function(msg)
            notify.notify(msg, 'Error')
        end
        nt.with_opts = function(msg, level, opts)
            notify.notify(msg)
        end
        local icon = require('neoment.icon')
        -- U+2022 (•): The standard bullet point; good for a simple, solid dot.
        icon.dot = '•'
    end,
    dev = true,
}
