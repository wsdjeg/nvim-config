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
-- vim.opt.runtimepath:append('D:/bundle_dir/wsdjeg/nvim-plug')
vim.opt.runtimepath:append('D:/wsdjeg/nvim-plug')

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
                '<leader>hl',
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
        'D:/wsdjeg/plugin-utils.nvim',
    },
    {
        'D:/wsdjeg/bookmarks.nvim',
        config = function()
            vim.keymap.set('n', 'mm', '<Plug>(bookmarksToggle)', { noremap = false })
            vim.keymap.set('n', 'mi', '<Plug>(bookmarksAnnotation)', { noremap = false })
            vim.keymap.set('n', 'mn', '<Plug>(bookmarksNext)', { noremap = false })
            vim.keymap.set('n', 'mc', '<Plug>(bookmarksClear)', { noremap = false })
            vim.keymap.set('n', 'ma', '<Plug>(bookmarksListAll)', { noremap = false })
            vim.keymap.set('n', 'mp', '<Plug>(bookmarksPrevious)', { noremap = false })
            require('bookmarks').setup({ sign_text = '🏷️' })
        end,
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
        'D:/wsdjeg/git.nvim',
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
        'wsdjeg/code-runner.nvim',
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
        'stevearc/aerial.nvim',
        cmds = { 'AerialToggle' },
        config = function()
            -- Call the setup function to change the default behavior
            require('aerial').setup({
                -- Priority list of preferred backends for aerial.
                -- This can be a filetype map (see :help aerial-filetype-map)
                backends = { 'treesitter', 'lsp', 'markdown', 'asciidoc', 'man' },

                layout = {
                    -- These control the width of the aerial window.
                    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- min_width and max_width can be a list of mixed types.
                    -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
                    max_width = { 40, 0.2 },
                    width = nil,
                    min_width = 35,

                    -- key-value pairs of window-local options for aerial window (e.g. winhl)
                    win_opts = {},

                    -- Determines the default direction to open the aerial window. The 'prefer'
                    -- options will open the window in the other direction *if* there is a
                    -- different buffer in the way of the preferred direction
                    -- Enum: prefer_right, prefer_left, right, left, float
                    default_direction = 'prefer_left',

                    -- Determines where the aerial window will be opened
                    --   edge   - open aerial at the far right/left of the editor
                    --   window - open aerial to the right/left of the current window
                    placement = 'window',

                    -- When the symbols change, resize the aerial window (within min/max constraints) to fit
                    resize_to_content = true,

                    -- Preserve window size equality with (:help CTRL-W_=)
                    preserve_equality = false,
                },

                -- Determines how the aerial window decides which buffer to display symbols for
                --   window - aerial window will display symbols for the buffer in the window from which it was opened
                --   global - aerial window will display symbols for the current window
                attach_mode = 'window',

                -- List of enum values that configure when to auto-close the aerial window
                --   unfocus       - close aerial when you leave the original source window
                --   switch_buffer - close aerial when you change buffers in the source window
                --   unsupported   - close aerial when attaching to a buffer that has no symbol source
                close_automatic_events = {},

                -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
                -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
                -- Additionally, if it is a string that matches "actions.<name>",
                -- it will use the mapping at require("aerial.actions").<name>
                -- Set to `false` to remove a keymap
                keymaps = {
                    ['?'] = 'actions.show_help',
                    ['g?'] = 'actions.show_help',
                    ['<CR>'] = 'actions.jump',
                    ['<2-LeftMouse>'] = 'actions.jump',
                    ['<C-v>'] = 'actions.jump_vsplit',
                    ['<C-s>'] = 'actions.jump_split',
                    ['p'] = 'actions.scroll',
                    ['<C-j>'] = 'actions.down_and_scroll',
                    ['<C-k>'] = 'actions.up_and_scroll',
                    ['{'] = 'actions.prev',
                    ['}'] = 'actions.next',
                    ['[['] = 'actions.prev_up',
                    [']]'] = 'actions.next_up',
                    ['q'] = 'actions.close',
                    ['o'] = 'actions.tree_toggle',
                    ['za'] = 'actions.tree_toggle',
                    ['O'] = 'actions.tree_toggle_recursive',
                    ['zA'] = 'actions.tree_toggle_recursive',
                    ['l'] = 'actions.tree_open',
                    ['zo'] = 'actions.tree_open',
                    ['L'] = 'actions.tree_open_recursive',
                    ['zO'] = 'actions.tree_open_recursive',
                    ['h'] = 'actions.tree_close',
                    ['zc'] = 'actions.tree_close',
                    ['H'] = 'actions.tree_close_recursive',
                    ['zC'] = 'actions.tree_close_recursive',
                    ['zr'] = 'actions.tree_increase_fold_level',
                    ['zR'] = 'actions.tree_open_all',
                    ['zm'] = 'actions.tree_decrease_fold_level',
                    ['zM'] = 'actions.tree_close_all',
                    ['zx'] = 'actions.tree_sync_folds',
                    ['zX'] = 'actions.tree_sync_folds',
                },

                -- When true, don't load aerial until a command or function is called
                -- Defaults to true, unless `on_attach` is provided, then it defaults to false
                lazy_load = true,

                -- Disable aerial on files with this many lines
                disable_max_lines = 10000,

                -- Disable aerial on files this size or larger (in bytes)
                disable_max_size = 2000000, -- Default 2MB

                -- A list of all symbols to display. Set to false to display all symbols.
                -- This can be a filetype map (see :help aerial-filetype-map)
                -- To see all available values, see :help SymbolKind
                filter_kind = {
                    'Class',
                    'Constructor',
                    'Enum',
                    'Function',
                    'Interface',
                    'Module',
                    'Method',
                    'Struct',
                },

                -- Determines line highlighting mode when multiple splits are visible.
                -- split_width   Each open window will have its cursor location marked in the
                --               aerial buffer. Each line will only be partially highlighted
                --               to indicate which window is at that location.
                -- full_width    Each open window will have its cursor location marked as a
                --               full-width highlight in the aerial buffer.
                -- last          Only the most-recently focused window will have its location
                --               marked in the aerial buffer.
                -- none          Do not show the cursor locations in the aerial window.
                highlight_mode = 'split_width',

                -- Highlight the closest symbol if the cursor is not exactly on one.
                highlight_closest = true,

                -- Highlight the symbol in the source buffer when cursor is in the aerial win
                highlight_on_hover = false,

                -- When jumping to a symbol, highlight the line for this many ms.
                -- Set to false to disable
                highlight_on_jump = 300,

                -- Jump to symbol in source window when the cursor moves
                autojump = false,

                -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
                -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
                -- default collapsed icon. The default icon set is determined by the
                -- "nerd_font" option below.
                -- If you have lspkind-nvim installed, it will be the default icon set.
                -- This can be a filetype map (see :help aerial-filetype-map)
                icons = {},

                -- Control which windows and buffers aerial should ignore.
                -- Aerial will not open when these are focused, and existing aerial windows will not be updated
                ignore = {
                    -- Ignore unlisted buffers. See :help buflisted
                    unlisted_buffers = false,

                    -- Ignore diff windows (setting to false will allow aerial in diff windows)
                    diff_windows = true,

                    -- List of filetypes to ignore.
                    filetypes = {},

                    -- Ignored buftypes.
                    -- Can be one of the following:
                    -- false or nil - No buftypes are ignored.
                    -- "special"    - All buffers other than normal, help and man page buffers are ignored.
                    -- table        - A list of buftypes to ignore. See :help buftype for the
                    --                possible values.
                    -- function     - A function that returns true if the buffer should be
                    --                ignored or false if it should not be ignored.
                    --                Takes two arguments, `bufnr` and `buftype`.
                    buftypes = 'special',

                    -- Ignored wintypes.
                    -- Can be one of the following:
                    -- false or nil - No wintypes are ignored.
                    -- "special"    - All windows other than normal windows are ignored.
                    -- table        - A list of wintypes to ignore. See :help win_gettype() for the
                    --                possible values.
                    -- function     - A function that returns true if the window should be
                    --                ignored or false if it should not be ignored.
                    --                Takes two arguments, `winid` and `wintype`.
                    wintypes = 'special',
                },

                -- Use symbol tree for folding. Set to true or false to enable/disable
                -- Set to "auto" to manage folds if your previous foldmethod was 'manual'
                -- This can be a filetype map (see :help aerial-filetype-map)
                manage_folds = false,

                -- When you fold code with za, zo, or zc, update the aerial tree as well.
                -- Only works when manage_folds = true
                link_folds_to_tree = false,

                -- Fold code when you open/collapse symbols in the tree.
                -- Only works when manage_folds = true
                link_tree_to_folds = true,

                -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
                -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
                nerd_font = 'auto',

                -- Call this function when aerial attaches to a buffer.
                on_attach = function(bufnr) end,

                -- Call this function when aerial first sets symbols on a buffer.
                on_first_symbols = function(bufnr) end,

                -- Automatically open aerial when entering supported buffers.
                -- This can be a function (see :help aerial-open-automatic)
                open_automatic = false,

                -- Run this command after jumping to a symbol (false will disable)
                post_jump_cmd = 'normal! zz',

                -- Invoked after each symbol is parsed, can be used to modify the parsed item,
                -- or to filter it by returning false.
                --
                -- bufnr: a neovim buffer number
                -- item: of type aerial.Symbol
                -- ctx: a record containing the following fields:
                --   * backend_name: treesitter, lsp, man...
                --   * lang: info about the language
                --   * symbols?: specific to the lsp backend
                --   * symbol?: specific to the lsp backend
                --   * syntax_tree?: specific to the treesitter backend
                --   * match?: specific to the treesitter backend, TS query match
                post_parse_symbol = function(bufnr, item, ctx)
                    return true
                end,

                -- Invoked after all symbols have been parsed and post-processed,
                -- allows to modify the symbol structure before final display
                --
                -- bufnr: a neovim buffer number
                -- items: a collection of aerial.Symbol items, organized in a tree,
                --        with 'parent' and 'children' fields
                -- ctx: a record containing the following fields:
                --   * backend_name: treesitter, lsp, man...
                --   * lang: info about the language
                --   * symbols?: specific to the lsp backend
                --   * syntax_tree?: specific to the treesitter backend
                post_add_all_symbols = function(bufnr, items, ctx)
                    return items
                end,

                -- When true, aerial will automatically close after jumping to a symbol
                close_on_select = false,

                -- The autocmds that trigger symbols update (not used for LSP backend)
                update_events = 'TextChanged,InsertLeave',

                -- Show box drawing characters for the tree hierarchy
                show_guides = false,

                -- Customize the characters used when show_guides = true
                guides = {
                    -- When the child item has a sibling below it
                    mid_item = '├─',
                    -- When the child item is the last in the list
                    last_item = '└─',
                    -- When there are nested child guides to the right
                    nested_top = '│ ',
                    -- Raw indentation
                    whitespace = '  ',
                },

                -- Set this function to override the highlight groups for certain symbols
                get_highlight = function(symbol, is_icon, is_collapsed)
                    -- return "MyHighlight" .. symbol.kind
                end,

                -- Options for opening aerial in a floating win
                float = {
                    -- Controls border appearance. Passed to nvim_open_win
                    border = 'rounded',

                    -- Determines location of floating window
                    --   cursor - Opens float on top of the cursor
                    --   editor - Opens float centered in the editor
                    --   win    - Opens float centered in the window
                    relative = 'cursor',

                    -- These control the height of the floating window.
                    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- min_height and max_height can be a list of mixed types.
                    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
                    max_height = 0.9,
                    height = nil,
                    min_height = { 8, 0.1 },

                    override = function(conf, source_winid)
                        -- This is the config that will be passed to nvim_open_win.
                        -- Change values here to customize the layout
                        return conf
                    end,
                },

                -- Options for the floating nav windows
                nav = {
                    border = 'rounded',
                    max_height = 0.9,
                    min_height = { 10, 0.1 },
                    max_width = 0.5,
                    min_width = { 0.2, 20 },
                    win_opts = {
                        cursorline = true,
                        winblend = 10,
                    },
                    -- Jump to symbol in source window when the cursor moves
                    autojump = false,
                    -- Show a preview of the code in the right column, when there are no child symbols
                    preview = false,
                    -- Keymaps in the nav window
                    keymaps = {
                        ['<CR>'] = 'actions.jump',
                        ['<2-LeftMouse>'] = 'actions.jump',
                        ['<C-v>'] = 'actions.jump_vsplit',
                        ['<C-s>'] = 'actions.jump_split',
                        ['h'] = 'actions.left',
                        ['l'] = 'actions.right',
                        ['<C-c>'] = 'actions.close',
                    },
                },

                lsp = {
                    -- If true, fetch document symbols when LSP diagnostics update.
                    diagnostics_trigger_update = false,

                    -- Set to false to not update the symbols when there are LSP errors
                    update_when_errors = true,

                    -- How long to wait (in ms) after a buffer change before updating
                    -- Only used when diagnostics_trigger_update = false
                    update_delay = 300,

                    -- Map of LSP client name to priority. Default value is 10.
                    -- Clients with higher (larger) priority will be used before those with lower priority.
                    -- Set to -1 to never use the client.
                    priority = {
                        -- pyright = 10,
                    },
                },

                treesitter = {
                    -- How long to wait (in ms) after a buffer change before updating
                    update_delay = 300,
                },

                markdown = {
                    -- How long to wait (in ms) after a buffer change before updating
                    update_delay = 300,
                },

                asciidoc = {
                    -- How long to wait (in ms) after a buffer change before updating
                    update_delay = 300,
                },

                man = {
                    -- How long to wait (in ms) after a buffer change before updating
                    update_delay = 300,
                },
            })
        end,
        config_before = function()
            vim.keymap.set('n', '<F2>', '<cmd>AerialToggle!<CR>')
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
