vim.api.nvim_create_user_command('IssueEdit', function(opt)
    local nt = require('notify')
    local isapi = require('github.issues')

    local issue = isapi.get(opt.fargs[1], opt.fargs[2], opt.fargs[3])

    local bufname = string.format('issue://%s/%s/%s', opt.fargs[1], opt.fargs[2], opt.fargs[3])

    local buf = vim.fn.bufnr(bufname, true)

    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
    vim.api.nvim_set_option_value('buftype', 'acwrite', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })

    vim.api.nvim_open_win(buf, true, { split = 'above' })

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(issue.body, '\n'))

    local augroup = vim.api.nvim_create_augroup('issue_edit', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWriteCmd' }, {
        buffer = buf,
        group = augroup,
        callback = function(ev)
            local response = isapi.update_issue(opt.fargs[1], opt.fargs[2], opt.fargs[3], {
                body = table.concat(vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false), '\n'),
            })
            if type(response) == 'table' and response.title then
                nt.notify('issue updated')
            else
                vim.print(response)
            end
            vim.api.nvim_set_option_value('modified', false, { buf = ev.buf })
        end,
    })
end, { nargs = '*' })
