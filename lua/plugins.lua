if vim.fn.isdirectory('D:/bundle_dir/wsdjeg/nvim-plug') == 0 then
    vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wsdjeg/nvim-plug.git',
        'D:/bundle_dir/wsdjeg/nvim-plug',
    })
end
vim.opt.runtimepath:append('D:/bundle_dir/wsdjeg/nvim-plug')

require('plug').setup({

    bundle_dir = 'D:/bundle_dir',
    raw_plugin_dir = 'D:/bundle_dir/raw_plugin',
    -- ui = 'notify',
    http_proxy = 'http://127.0.0.1:7890',
    https_proxy = 'http://127.0.0.1:7890',
    enable_priority = false,
    max_processes = 16,
})

require('plug').add({
    {
        'wsdjeg/logger.nvim',
        priority = 99,
        config = function()
            require('logger').setup({ level = 0 })
            vim.keymap.set(
                'n',
                '<leader>hL',
                '<cmd>lua require("logger").viewRuntimeLog()<cr>',
                { silent = true }
            )
        end,
    },
    {
        'wsdjeg/notify.nvim',
        priority = 100,
    },
    {
        'wsdjeg/job.nvim',
        priority = 100,
    },
    {
        'wsdjeg/nvim-plug',
        fetch = true,
    },
    {
        'D:/wsdjeg/keymap-guide.nvim',
    },
    {
        'wsdjeg/music-player.nvim',
        config = function()
            require('music-player').setup({
                musics_directory = 'D:\\wsdjeg\\my-blog\\docs\\musics',
            })
            vim.keymap.set(
                'n',
                '<leader>ms',
                '<cmd>lua require("music-player").stop()<cr>',
                { silent = true }
            )
            vim.keymap.set('n', '<leader>mf', '<cmd>Telescope music-player<cr>', { silent = true })
        end,
    },
    -- 一些常用仓库，让 nvim-plug 帮我下载并更新，但不加入 vim 插件列表。
    { 'neovim/neovim', fetch = true },
    { 'vim/vim', fetch = true },
    { 'wsdjeg/SpaceVim', fetch = true },
})
require('plug').add({
    {
        'wsdjeg/git.nvim',
        config_before = function()
            vim.keymap.set('n', '<leader>gs', '<cmd>Git status<cr>', { silent = true })
            vim.keymap.set('n', '<leader>gA', '<cmd>Git add .<cr>', { silent = true })
            vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>', { silent = true })
            vim.keymap.set('n', '<leader>gv', '<cmd>Git log<cr>', { silent = true })
            vim.keymap.set('n', '<leader>gV', '<cmd>Git log %<cr>', { silent = true })
            vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>', { silent = true })
            vim.keymap.set('n', '<leader>gd', '<cmd>Git diff<cr>', { silent = true })
        end,
    },
    {
        'wsdjeg/rooter.nvim',
        config = function()
            require('rooter').setup({
                root_pattern = { '.git/' },
                enable_logger = true,
            })
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
        'olimorris/codecompanion.nvim',
        config = function()
            require('codecompanion').setup({
                strategies = {
                    chat = {
                        adapter = 'anthropic',
                    },
                    inline = {
                        adapter = 'anthropic',
                    },
                },
            })
        end,
        cmds = { 'CodeCompanionChat' },
        depends = {
            { 'nvim-lua/plenary.nvim' },
            {
                'nvim-treesitter/nvim-treesitter',
                config = function()
                    require('nvim-treesitter.configs').setup({
                        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                        ensure_installed = {
                            'c',
                            'lua',
                            'vim',
                            'vimdoc',
                            'query',
                            'markdown',
                            'markdown_inline',
                        },

                        -- Install parsers synchronously (only applied to `ensure_installed`)
                        sync_install = false,

                        -- Automatically install missing parsers when entering buffer
                        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                        auto_install = true,

                        -- List of parsers to ignore installing (or "all")
                        ignore_install = { 'javascript' },

                        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                        highlight = {
                            enable = true,

                            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                            -- the name of the parser)
                            -- list of language that will be disabled
                            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                            disable = function(lang, buf)
                                local max_filesize = 100 * 1024 -- 100 KB
                                local ok, stats =
                                    pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                                if ok and stats and stats.size > max_filesize then
                                    return true
                                end
                            end,

                            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                            -- Using this option may slow down your editor, and you may see some duplicate highlights.
                            -- Instead of true it can also be a list of languages
                            additional_vim_regex_highlighting = false,
                        },
                    })
                end,
            },
        },
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
        'D:/wsdjeg/code-runner.nvim',
        config = function()
            require('plugins.code-runner')
        end,
    },
    { 'wsdjeg/tasks.nvim' },
    { 'rhysd/clever-f.vim' },
    { 'mzlogin/vim-markdown-toc' },
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
        'wsdjeg/scrollbar.vim',
        events = { 'VimEnter' },
        config = function() end,
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
                return '%{ v:lua.require("git.command.branch").current() }'
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
        'D:/wsdjeg/record-key.nvim',
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
        'nvim-tree/nvim-tree.lua',
        config_before = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            vim.keymap.set('n', '<F3>', '<cmd>NvimTreeToggle<cr>', { silent = true })
            vim.keymap.set('n', '<leader>fo', function()
                local ok, api = pcall(require, 'nvim-tree.api')
                if ok then
                    api.tree.change_root(vim.fn.getcwd())
                    api.tree.open({
                        find_file = true,
                    })
                else
                    vim.cmd('NvimTreeFindFile')
                end
            end, { silent = true })
        end,
        config = function()
            require('nvim-tree').setup({
                sort = {
                    sorter = 'case_sensitive',
                },
                view = {
                    width = 35,
                    side = 'right',
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end,
        cmds = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile' },
        depends = {
            { 'nvim-tree/nvim-web-devicons' },
        },
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
        cmds = { 'Format' },
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
        'wsdjeg/vim-zettelkasten',
        config_before = function()
            vim.g.zettelkasten_directory = 'D:/wsdjeg/my-blog/zettelkasten'
            vim.g.zettelkasten_template_directory = 'D:/wsdjeg/my-blog/zettelkasten_template'
        end,
        config = function()
            vim.keymap.set('n', '<leader>mzb', '<cmd>ZkBrowse<cr>', { silent = true })
            vim.keymap.set('n', '<leader>mzn', '<cmd>ZkNew<cr>', { silent = true })
            vim.keymap.set('n', '<leader>mzf', '<cmd>ZkListNotes<cr>', { silent = true })
            vim.keymap.set('n', '<leader>mzt', '<cmd>ZkListTags<cr>', { silent = true })
        end,
    },
    {
        'preservim/tagbar',
        cmds = { 'TagbarToggle' },
        config_before = function()
            vim.keymap.set('n', '<F2>', '<cmd>TagbarToggle<cr>', { silent = true })

            vim.g.tagbar_width = 30
            vim.g.tagbar_left = 1
            vim.g.tagbar_iconchars = { '▶', '▼' }
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
        'nvim-telescope/telescope.nvim',
        cmds = { 'Telescope' },
        depends = {
            {
                'nvim-lua/plenary.nvim',
            },
            {
                'fcying/telescope-ctags-outline.nvim',
            },
        },
        config_before = function()
            vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>', { silent = true })
            vim.keymap.set('n', '<leader>fr', '<cmd>Telescope mru<cr>', { silent = true })
            vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', { silent = true })
            vim.keymap.set('n', '<leader>ji', '<cmd>Telescope ctags_outline<cr>', { silent = true })
            vim.keymap.set('n', '<leader>pl', '<cmd>Telescope project<cr>', { silent = true })
        end,
        config = function()
            local actions = require('telescope.actions')
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            -- the default key binding should same as other fuzzy finder layer
                            -- tab move to next
                            ['<C-j>'] = actions.move_selection_next,
                            ['<Tab>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<S-Tab>'] = actions.move_selection_previous,
                            ['<Esc>'] = actions.close,
                            ['<C-h>'] = 'which_key',
                        },
                    },
                    sorting_strategy = 'ascending',
                    layout_config = {
                        prompt_position = 'bottom',
                    },
                },
            })
        end,
    },
    {
        'mfussenegger/nvim-lint',
        config = function()
            vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    -- require('lint').try_lint()
                end,
            })
        end,
    },
    {
        'wsdjeg/record-screen.nvim',
        config = function()
            require('plugins.record-screen')
        end,
    },
    {
        'NStefan002/2048.nvim',
        config = function()
            require('2048').setup()
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
