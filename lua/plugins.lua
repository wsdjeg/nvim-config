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
        dev = true,
    },
})
require('plug').add({
    {
        'wsdjeg/mru.nvim',
        events = { 'UIEnter' },
        opts = {
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
        },
        dev = true,
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
        on_map = { '<leader>lr' },
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
        keys = {
            {
                'n',
                '<leader>ao',
                '<cmd>lua require("todo").list()<cr>',
                { silent = true },
            },
        },
        dev = true,
    },
    {
        'wsdjeg/terminal.nvim',
        keys = {
            {
                'n',
                "<leader>'",
                '<cmd>lua require("terminal").open()<cr>',
                { silent = true, desc = 'open terminal in current path' },
            },
            {
                'n',
                '<leader>"',
                '<cmd>lua require("terminal").open(vim.fn.expand("%:p:h"))<cr>',
                { silent = true, desc = 'open terminal in file path' },
            },
        },
        dev = true,
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
                events = { 'InsertEnter' },
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
        events = { 'UIEnter' },
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
        'wsdjeg/dashboard-nvim',
        events = { 'VimEnter' },
        config = function()
            require('dashboard').setup({
                shortcut_type = 'number',
                config = { project = { enable = false } },
            })
            vim.keymap.set('n', '<leader>as', '<cmd>Dashboard<cr>', { silent = true })
        end,
        dev = true,
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
        keys = {
            { 'n', '<leader>jl', '<cmd>HopLine<cr>', { silent = true, desc = 'hop jump line' } },
            { 'n', '<leader>jj', '<cmd>HopChar1<cr>', { silent = true, desc = 'hop jump char' } },
        },
        cmds = { 'HopWord', 'HopLine', 'HopChar1' },
        opts = {},
    },
    {
        'wsdjeg/ctrlg.nvim',
        keys = {
            {
                'n',
                '<C-g>',
                '<cmd>lua require("ctrlg").display()<cr>',
                { silent = true, desc = 'ctrlg info' },
            },
        },
    },
    {
        'mhinz/vim-signify',
        events = { 'VimEnter' },
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
        events = { 'InsertEnter' },
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
        dev = true,
        on_map = { '<leader>fy', '<leader>fY' },
    },
})
require('plug').load()
