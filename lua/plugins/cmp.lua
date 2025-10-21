local cmp = require('cmp')
vim.lsp.enable('luals')
vim.o.tagbsearch = false

local function ctrl_p(f) -- {{{
    if cmp.visible() then
        cmp.select_prev_item()
    else
        pcall(f)
    end
end
-- }}}

local function ctrl_n(f) -- {{{
    if cmp.visible() then
        cmp.select_next_item()
    else
        pcall(f)
    end
end
-- }}}

-- }}}
local kind_icons = {
    Text = '',
    Method = '󰆧',
    Function = '󰊕',
    Constructor = '',
    Field = '󰇽',
    Variable = '󰂡',
    Class = '󰠱',
    Interface = '',
    Module = '',
    Property = '󰜢',
    Unit = '',
    Value = '󰎠',
    Enum = '',
    Keyword = '󰌋',
    Snippet = '',
    Color = '󰏘',
    File = '󰈙',
    Reference = '',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '󰏿',
    Struct = '',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '󰅲',
}
--2. `auto_completion_tab_key_behavior` set the action to
--   perform when the `TAB` key is pressed, the possible values are:
--   - `smart` cycle candidates, expand snippets, jump parameters
--   - `complete` completes with the current selection
--   - `cycle` completes the common prefix and cycle between candidates
--   - `nil` insert a carriage return
--   By default it is `complete`.

cmp.setup({
    enabled = function()
        -- https://github.com/nvim-tree/nvim-tree.lua/pull/3207
        if vim.tbl_contains({'NvimTreeFilter', 'snacks_picker_input'}, vim.bo.filetype) then
            return false
        end
        return true
    end,
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-y>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                fallback()
                cmp.mapping.abort()
            else
                fallback()
            end
        end, { 'i' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<C-n>'] = ctrl_n,
        ['<C-p>'] = ctrl_p,
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if require('luasnip').expandable() then
                    require('luasnip').expand()
                else
                    cmp.confirm({
                        select = false,
                    })
                    return cmp.close()
                end
            else
                fallback()
            end
        end),

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require('luasnip').locally_jumpable(1) then
                require('luasnip').jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require('luasnip').locally_jumpable(-1) then
                require('luasnip').jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            vim_item.menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[LaTeX]',
            })[entry.source.name]
            return vim_item
        end,
        expandable_indicator = true,
        fields = { 'abbr', 'kind', 'menu' },
    },
    window = {
        completion = cmp.config.window.bordered({
            winhighlight = 'Normal:Normal,FloatBorder:WinSeparator,CursorLine:Visual,Search:None',
        }),
        documentation = cmp.config.window.bordered({
            winhighlight = 'Normal:Normal,FloatBorder:WinSeparator,CursorLine:Visual,Search:None',
        }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }, {
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end,
            },
        },
        {
            name = 'dictionary',
            keyword_length = 2,
        },
        {
            name = 'emoji',
            option = {
                insert = true,
            },
        },
    }),
})
