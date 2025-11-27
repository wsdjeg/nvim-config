return {
    'wsdjeg/picker.nvim',
    opts = {
        window = { enable_preview = true },
        highlight = {
            matched = 'Tag',
        },
        prompt = {
            position = 'top',
        },
    },
    cmds = { 'Picker' },
    keys = {
        {
            'n',
            '<C-p>',
            '<cmd>Picker async_files<cr>',
            { silent = true, desc = 'fuzzy find files in current dir' },
        },
        {
            'n',
            '<leader>fr',
            '<cmd>Picker mru<cr>',
            { silent = true, desc = 'fuzzy find most recent used files' },
        },
        {

            'n',
            '<leader>fi',
            '<cmd>Picker help_tags --input=<cword><cr>',
            { silent = true, desc = 'picker cursor help tag' },
        },
        {

            'n',
            '<leader>bb',
            '<cmd>Picker buffers<cr>',
            { silent = true, desc = 'fuzzy find listed buffers' },
        },
        {
            'n',
            '<leader>ji',
            '<cmd>Picker buftags<cr>',
            { silent = true, desc = 'fuzzy find ctags outline' },
        },
        {
            'n',
            '<leader>fl',
            '<cmd>Picker lines<cr>',
            { silent = true, desc = 'fuzzy find lines in current buffer' },
        },
        {
            'n',
            '<leader>ff',
            '<cmd>Picker<cr>',
            { silent = true, desc = 'fuzzy find picker source' },
        },
        {
            'n',
            '<leader>?',
            '<cmd>Picker key-mappings<cr>',
            { silent = true, desc = 'fuzzy find key mappings' },
        },
    },
    config = function()
        vim.ui.select = function(items, opt, callback)
            local source = {}
            opt = opt or {}
            if opt.prompt then
                source.name = opt.prompt
            else
                source.name = 'Select one of:'
            end

            source.get = function()
                local entrys = {}
                for idx, item in ipairs(items) do
                    local entry = {
                        value = item,
                        idx = idx, -- this also can be nil
                    }

                    if opt.format_item then
                        entry.str = opt.format_item(item)
                    else
                        entry.str = item
                    end
                    table.insert(entrys, entry)
                end
                return entrys
            end

            source.default_action = function(entry)
                if callback then
                    callback(entry.value, entry.idx)
                end
            end

            require('picker.windows').open(source, {
                buf = vim.api.nvim_get_current_buf(),
            })
        end
    end,
    type = 'rocks',
    dev = true,
    desc = 'a lightweight, high-performance fuzzy finder for Neovim',
}
