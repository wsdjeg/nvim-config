local bundle_dir = 'D:/'

local function bootstrap(repo)
    if vim.fn.isdirectory(bundle_dir .. repo) == 0 then
        vim.fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'git@github.com:' .. repo .. '.git',
            bundle_dir .. repo,
        })
    end
    vim.opt.runtimepath:append(bundle_dir .. repo)
end

bootstrap('wsdjeg/job.nvim')
bootstrap('wsdjeg/logger.nvim')
bootstrap('wsdjeg/nvim-plug')

require('plug').setup({

    bundle_dir = 'D:/bundle_dir',
    raw_plugin_dir = 'D:/bundle_dir/raw_plugin',
    -- ui = 'notify',
    http_proxy = 'http://127.0.0.1:7890',
    https_proxy = 'http://127.0.0.1:7890',
    enable_priority = false,
    max_processes = 16,
    dev_path = 'D:/',
})

require('plug').add({
    {
        'wsdjeg/logger.nvim',
        priority = 99,
        config = function()
            require('logger').setup({ level = 0 })
            vim.keymap.set(
                'n',
                '<leader>hl',
                '<cmd>lua require("logger").viewRuntimeLog()<cr>',
                { silent = true }
            )
        end,
    },
    {
        'wsdjeg/notify.nvim',
    },
    {
        'wsdjeg/job.nvim',
        fetch = true,
    },
    {
        'wsdjeg/nvim-plug',
        fetch = true,
    },
    {
        'sbdchd/neoformat',
        fetch = true,
    },
    {
        'wsdjeg/keymap-guide.nvim',
        fetch = true,
    },
    {
        'wsdjeg/plugin-utils.nvim',
        fetch = true,
    },
    {
        'wsdjeg/bookmarks.nvim',
        config = function()
            vim.keymap.set('n', 'mm', '<Plug>(bookmarksToggle)', { noremap = false })
            vim.keymap.set('n', 'mi', '<Plug>(bookmarksAnnotation)', { noremap = false })
            vim.keymap.set('n', 'mn', '<Plug>(bookmarksNext)', { noremap = false })
            vim.keymap.set('n', 'mc', '<Plug>(bookmarksClear)', { noremap = false })
            vim.keymap.set('n', 'ma', '<Plug>(bookmarksListAll)', { noremap = false })
            vim.keymap.set('n', 'mp', '<Plug>(bookmarksPrevious)', { noremap = false })
            require('bookmarks').setup({ sign_text = '⚑' })
            vim.keymap.set(
                'n',
                '<leader>fb',
                '<cmd>Picker bookmarks<cr>',
                { silent = true, desc = 'fuzzy find bookmarks' }
            )
        end,
        dev = true,
    },
    -- 一些常用仓库，让 nvim-plug 帮我下载并更新，但不加入 vim 插件列表。
    { 'neovim/neovim', fetch = true },
    { 'vim/vim', fetch = true },
    { 'wsdjeg/SpaceVim', fetch = true },
})
require('plug').add({
    {
        'wsdjeg/rooter.nvim',
        config = function()
            require('rooter').setup({
                root_pattern = { '.git/' },
                enable_logger = true,
            })
            vim.keymap.set(
                'n',
                '<leader>fp',
                '<cmd>Picker project<cr>',
                { silent = true, desc = 'fuzzy find recent project' }
            )
        end,
    },
    {
        'wsdjeg/mru.nvim',
        config = function()
            require('mru').setup({
                enable_cache = true,
                ignore_path_regexs = {
                    '/.git/',
                    '/nvim/runtime/doc/',
                    '.mp3$',
                    '.mp4$',
                    '.png$',
                    '.jpg$',
                },
                enable_logger = true,
            })
        end,
        dev = true,
    },
    {
        'wsdjeg/repl.nvim',
        config = function()
            require('repl').setup({ executables = { lua = 'lua', python = 'python' } })
            vim.keymap.set(
                'n',
                '<leader>lsi',
                '<cmd>lua require("repl").start(vim.o.filetype)<cr>',
                { silent = true }
            )
            vim.keymap.set(
                'n',
                '<leader>lsl',
                '<cmd>lua require("repl").send("line")<cr>',
                { silent = true }
            )
        end,
    },
    {
        'wsdjeg/ctags.nvim',
        config = function()
            require('ctags').setup()

            local function update_ctags_option()
                local project_root = vim.fn.getcwd()
                local dir = require('ctags.util').unify_path(require('ctags.config').cache_dir)
                    .. require('ctags.util').path_to_fname(project_root)
                local tags = vim.tbl_filter(function(t)
                    return not vim.startswith(
                        t,
                        require('ctags.util').unify_path(require('ctags.config').cache_dir)
                    )
                end, vim.split(vim.o.tags, ','))
                table.insert(tags, dir .. '/tags')
                vim.o.tags = table.concat(tags, ',')
            end
            vim.fn.timer_start(500, function()
                require('rooter').reg_callback(update_ctags_option)
            end, { ['repeat'] = 1 })
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        cmds = { 'RenderMarkdown' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
    {
        'toppair/peek.nvim',
        build = 'deno task --quiet build:fast',
        cmds = { 'PeekOpen', 'PeekClose' },
        config_before = function()
            vim.keymap.set('n', '<leader>lp', '<cmd>PeekOpen<cr>', { silent = true })
        end,
        config = function()
            -- default config:
            require('peek').setup({
                auto_load = true, -- whether to automatically load preview when
                -- entering another markdown buffer
                close_on_bdelete = true, -- close preview window on buffer delete

                syntax = true, -- enable syntax highlighting, affects performance

                theme = 'dark', -- 'dark' or 'light'

                update_on_change = true,

                app = 'browser', -- 'webview', 'browser', string or a table of strings
                -- explained below

                filetype = { 'markdown' }, -- list of filetypes to recognize as markdown

                -- relevant if update_on_change is true
                throttle_at = 200000, -- start throttling when file exceeds this
                -- amount of bytes in size
                throttle_time = 'auto', -- minimum amount of time in milliseconds
                -- that has to pass before starting new render
            })
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
            vim.keymap.set('n', '<leader>lp', '<cmd>PeekOpen<cr>', { silent = true })
        end,
    },
    {
        'wsdjeg/cpicker.nvim',
        cmds = {
            'Cpicker',
            'CpickerCursorForeground',
            'CpickerColorMix',
            'CpickerCursorChangeHighlight',
            'CpickerClearColorPatch',
        },
    },
    { 'wsdjeg/ChineseLinter.vim', cmds = { 'CheckChinese' } },
    {
        'wsdjeg/code-runner.nvim',
        config = function()
            require('plugins.code-runner')
        end,
    },
    { 'wsdjeg/tasks.nvim' },
    { 'rhysd/clever-f.vim' },
    {
        'mzlogin/vim-markdown-toc',
        config = function()
            vim.g.vmt_list_item_char = '-'
        end,
    },
    {
        'wsdjeg/todo.nvim',
        config = function()
            vim.keymap.set(
                'n',
                '<leader>ao',
                '<cmd>lua require("todo").list()<cr>',
                { silent = true }
            )
        end,
    },
    {
        'wsdjeg/terminal.nvim',
        config = function()
            vim.keymap.set(
                'n',
                "<leader>'",
                '<cmd>lua require("terminal").open()<cr>',
                { silent = true }
            )
            vim.keymap.set(
                'n',
                '<leader>"',
                '<cmd>lua require("terminal").open(vim.fn.expand("%:p:h"))<cr>',
                { silent = true }
            )
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.cmp')
        end,
        depends = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-emoji' },
            {
                'L3MON4D3/LuaSnip',
                priority = 60,
                config = function()
                    local paths = {}
                    paths[#paths + 1] = require('plug.config').bundle_dir
                        .. '/honza/vim-snippets/snippets'
                    paths[#paths + 1] = vim.fn.stdpath('config') .. '/snippets'
                    require('luasnip').config.setup({ enable_autosnippets = true })
                    require('luasnip.loaders.from_snipmate').lazy_load({ paths = paths })
                end,
            },
            {
                'uga-rosa/cmp-dictionary',
                config = function()
                    require('cmp_dictionary').setup({
                        paths = { 'D:/me/dict/words.txt' },
                        exact_length = 2,
                    })
                end,
            },
            { 'onsails/lspkind.nvim' },
            { 'honza/vim-snippets' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' },
        },
    },
    {
        'wsdjeg/scrollbar.nvim',
        events = { 'VimEnter' },
        config = function()
            require('scrollbar').setup({
                max_size = 10,
                min_size = 5,
                width = 1,
                right_offset = 1,
                excluded_filetypes = {
                    'startify',
                    'git-commit',
                    'leaderf',
                    'NvimTree',
                    'tagbar',
                    'defx',
                    'neo-tree',
                    'qf',
                },
                shape = {
                    head = '▲',
                    body = '█',
                    tail = '▼',
                },
                highlight = {
                    head = 'Normal',
                    body = 'Normal',
                    tail = 'Normal',
                },
            })
        end,
    },
    {
        'wsdjeg/iedit.nvim',
        config = function()
            vim.keymap.set(
                'n',
                '<leader>se',
                "<cmd>lua require('iedit').start()<cr>",
                { silent = true }
            )
        end,
    },
    {
        'yorickpeterse/nvim-window',
        config = function()
            vim.keymap.set(
                'n',
                'sj',
                "<cmd>lua require('nvim-window').pick()<cr>",
                { silent = true }
            )
        end,
    },
    {
        'kylechui/nvim-surround',
        events = { 'VimEnter' },
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        'wsdjeg/statusline.nvim',
        events = { 'VimEnter' },
        config = function()
            require('statusline').register_sections('vcs', function()
                return '%{ v:lua.require("git.command.branch").current() .. v:lua.require("git.command.pull").status() .. v:lua.require("git.command.push").status() }'
            end)
            require('statusline').setup({
                left_sections = { 'winnr', 'filename', 'vcs' },
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
    },
    {
        'wsdjeg/tabline.nvim',
        events = { 'VimEnter' },
        config = function()
            for i = 1, 9, 1 do
                vim.keymap.set('n', '\\' .. i, function()
                    require('tabline').jump(i)
                end, { silent = true })
            end

            require('tabline').setup({ show_index = true })
        end,
    },
    {
        'wsdjeg/dashboard-nvim',
        events = { 'VimEnter' },
        config = function()
            require('dashboard').setup({
                shortcut_type = 'number',
                config = { project = { enable = false } },
            })
            vim.keymap.set('n', '<leader>as', '<cmd>Dashboard<cr>', { silent = true })
        end,
    },
    {
        'wsdjeg/record-key.nvim',
        cmds = { 'RecordKeyToggle' },
        config_before = function()
            vim.keymap.set('n', '<F9>', '<cmd>RecordKeyToggle<cr>', { silent = true })
        end,
        config = function()
            require('record-key').setup({
                timeout = 3000,
                max_count = 7,
                winhighlight = 'NormalFloat:Todo,FloatBorder:WinSeparator',
            })
        end,
    },
    {
        'wsdjeg/winbar.nvim',
        enabled = false,
    },
    {
        'smoka7/hop.nvim',
        config_before = function()
            vim.keymap.set('n', '<leader>jl', '<cmd>HopLine<cr>', { silent = true })
            vim.keymap.set('n', '<leader>jj', '<cmd>HopChar1<cr>', { silent = true })
        end,
        cmds = { 'HopWord', 'HopLine', 'HopChar1' },
        config = function()
            require('hop').setup({})
        end,
    },
    {
        'wsdjeg/ctrlg.nvim',
        config = function()
            vim.keymap.set(
                'n',
                '<C-g>',
                '<cmd>lua require("ctrlg").display()<cr>',
                { silent = true }
            )
        end,
    },
    {
        'mhinz/vim-signify',
        events = { 'VimEnter' },
    },
    {
        'wsdjeg/format.nvim',
        config = function()
            require('format').setup({
                custom_formatters = {
                    lua = {
                        exe = 'stylua',
                        args = { '-' },
                        stdin = true,
                    },
                },
            })
        end,
        config_before = function()
            vim.keymap.set('n', '<leader>bf', '<cmd>Format<cr>', { silent = true })
            vim.keymap.set('n', '<leader>lf', function()
                local cf = vim.call('context_filetype#get')
                if vim.o.filetype == 'markdown' and cf.filetype ~= 'markdown' then
                    local line1 = cf['range'][1][1]
                    local line2 = cf['range'][2][1]
                    vim.cmd(string.format('%s,%sFormat! %s', line1, line2, cf.filetype))
                end
            end, { silent = true })
        end,
        cmds = { 'Format', 'FormatWrite' },
        depends = { { 'Shougo/context_filetype.vim' } },
    },
    {
        'rakr/vim-one',
        config = function()
            vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
                pattern = { 'one' },
                group = vim.api.nvim_create_augroup('colorscheme-one', { clear = true }),
                callback = function()
                    -- DashboardHeader DashboardFooter
                    -- Hyper theme
                    -- DashboardProjectTitle DashboardProjectTitleIcon DashboardProjectIcon
                    -- DashboardMruTitle DashboardMruIcon DashboardFiles DashboardShortCutIcon
                    vim.cmd([[
          hi VertSplit guibg=#282c34 guifg=#181A1F
          hi SPCFloatBorder guibg=#282c34 guifg=#181A1F
          hi SPCNormalFloat guifg=#abb2bf guibg=#282c34
          hi EndOfBuffer guifg=#282c34 guifg=#282c34
          hi clear StatusLineNC
          hi link StatusLineNC Normal
          hi link WinSeparator VertSplit
          hi link DashboardHeader Number
          hi link DashboardFooter Number
          hi link DashboardFiles Comment
          hi link DashboardShortCutIcon Character
          hi link DashboardMruTitle Todo
          hi link DashboardMruIcon Label
          ]])
                end,
            })
            vim.cmd([[
      colorscheme one
      ]])
        end,
        priority = 100,
    },
    {
        'wsdjeg/flygrep.nvim',
        cmds = { 'FlyGrep', 'FlyGrepCword' },
        config = function()
            require('flygrep').setup({
                timeout = 200,
                color_templete = {
                    a = {
                        fg = '#2c323c',
                        bg = '#98c379',
                        ctermfg = 16,
                        ctermbg = 114,
                        bold = true,
                    },
                    b = {
                        fg = '#abb2bf',
                        bg = '#3b4048',
                        ctermfg = 145,
                        ctermbg = 16,
                        bold = false,
                    },
                },

                command = {
                    execute = 'rg',
                    default_opts = {
                        '--no-heading',
                        '--color=never',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '-g',
                        '!.git',
                    },
                    expr_opt = '-e',
                    fixed_string_opt = '-F',
                    default_fopts = { '-N' },
                    smart_case = '-S',
                    ignore_case = '-i',
                    hidden_opt = '--hidden',
                },

                matched_higroup = 'IncSearch',

                enable_preview = false,
                window = {
                    width = 0.9,
                    height = 0.9,
                    col = 0.05,
                    row = 0.05,
                },
            })
            vim.api.nvim_create_user_command('FlyGrepCword', function(opt)
                require('flygrep').open({ input = vim.fn.expand('<cword>') })
            end, { nargs = '*' })
        end,
        config_before = function()
            vim.keymap.set('n', '<leader>s/', '<cmd>FlyGrep<cr>', { silent = true })
            vim.keymap.set('n', '<leader>sp', '<cmd>FlyGrepCword<cr>', { silent = true })
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup({
                exclude = { filetypes = { 'dashboard' } },
                scope = { enabled = false },
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    },
    {
        'wsdjeg/record-screen.nvim',
        config = function()
            require('plugins.record-screen')
        end,
    },
    {
        'wsdjeg/gitlink.nvim',
        config = function()
            require('gitlink').setup()
            vim.keymap.set('n', '<leader>fy', function()
                require('gitlink').copy()
            end, { silent = true })
            vim.keymap.set('n', '<leader>fY', function()
                require('gitlink').open()
            end, { silent = true })
        end,
    },
})
require('plug').load()
