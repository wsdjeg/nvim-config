local log = require('logger').derive('logevent')
local id
vim.api.nvim_create_user_command('LogEvent', function(opt)
    if not id then
        local group = vim.api.nvim_create_augroup('logevent', { clear = true })
        id = vim.api.nvim_create_autocmd(
            vim.tbl_filter(function(e)
                return not vim.endswith(e, 'Cmd')
            end, vim.fn.getcompletion('', 'event')),
            {
                callback = vim.schedule_wrap(function(event)
                    if event.event ~= 'SafeState' then
                        log.debug(event.event .. event.buf)
                    end
                end),
                group = group,
            }
        )
    else
        vim.api.nvim_create_augroup('logevent', { clear = true })
        id = nil
    end
end, { nargs = '*' })

vim.keymap.set('n', '<F7>', '<cmd>LogEvent<Cr>', { silent = true })
