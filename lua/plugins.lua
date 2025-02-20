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
  ui = 'default',
  http_proxy = 'http://127.0.0.1:7890',
  https_proxy = 'http://127.0.0.1:7890',
  enable_priority = true,
  max_processes = 16,
})

require('plug').add({
  {
    'wsdjeg/git.vim',
    cmds = { 'Git' },
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
    'wsdjeg/nvim-plug',
    fetch = true,
  },
  {
    'wsdjeg/rooter.nvim',
    config = function()
      require('rooter').setup({
        root_pattern = { '.git/' },
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    events = { 'InsertEnter' },
    config_after = function()
      local cmp = require('cmp')
      vim.o.tagbsearch = false

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local function expand_snippet(_) -- {{{
        if vim.fn['neosnippet#expandable']() == 1 then
          feedkey('<plug>(neosnippet_expand)', '')
        end
      end
      -- }}}

      local function smart_tab(fallback) -- {{{
        if vim.fn['neosnippet#expandable_or_jumpable']() == 1 then
          feedkey('<plug>(neosnippet_expand_or_jump)', '')
        elseif cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end

      --1. `auto_completion_return_key_behavior` set the action to perform
      --   when the `Return`/`Enter` key is pressed. the possible values are:
      --   - `complete` completes with the current selection
      --   - `smart` completes with current selection and expand snippet or argvs
      --   - `nil`
      --   By default it is `complete`.

      local function enter(f) -- {{{
        expand_snippet(nil)
        if cmp.visible() then
          cmp.mapping.confirm({ select = false })
          return cmp.close()
        else
          pcall(f)
        end
      end
      -- }}}

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
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<Tab>'] = smart_tab,
          ['<M-/>'] = expand_snippet,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ['<C-n>'] = ctrl_n,
          ['<C-p>'] = ctrl_p,
          ['<CR>'] = enter,
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
          {
            name = 'dictionary',
            keyword_length = 2,
          },
          { name = 'path' },
          { name = 'neosnippet' },
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
        }),
      })
      -- `/` cmdline setup.
      -- cmp.setup.cmdline('/', {
      -- mapping = cmp.mapping.preset.cmdline(),
      -- sources = {
      -- { name = 'buffer' },
      -- },
      -- })
      -- `/` cmdline setup.
      -- cmp.setup.cmdline(':', {
      -- mapping = cmp.mapping.preset.cmdline(),
      -- sources = {
      -- { name = 'buffer' },
      -- { name = 'path' },
      -- },
      -- })
      -- Setup lspconfig.
      -- local capabilities =
      -- require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

      -- for cmp dictionary
      local dict = require('cmp_dictionary')

      dict.setup({
        -- The following are default values.
        exact = 2,
        first_case_insensitive = false,
        document = false,
        -- document_command = "wn %s -over",
        async = true,
        sqlite = false,
        max_items = -1,
        capacity = 5,
        debug = false,
      })

      -- dict.switcher({
      -- filetype = {
      -- lua = '/path/to/lua.dict',
      -- javascript = { '/path/to/js.dict', '/path/to/js2.dict' },
      -- },
      -- filepath = {
      -- ['.*xmake.lua'] = { '/path/to/xmake.dict', '/path/to/lua.dict' },
      -- ['%.tmux.*%.conf'] = { '/path/to/js.dict', '/path/to/js2.dict' },
      -- },
      -- spelllang = {
      -- en = '/path/to/english.dict',
      -- },
      -- })
    end,
    depends = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'Shougo/neosnippet.vim' },
      { 'Shougo/neosnippet-snippets' },
      { 'uga-rosa/cmp-dictionary' },
      { 'onsails/lspkind.nvim' },
      { 'notomo/cmp-neosnippet' },
    },
  },
  {
    'wsdjeg/scrollbar.vim',
    events = { 'VimEnter' },
    config = function() end,
  },
  {
    'nvim-lualine/lualine.nvim',
    events = { 'VimEnter' },
    config = function()
      require('lualine').setup()
    end,
  },
  {
    'wsdjeg/dashboard-nvim',
    events = { 'VimEnter' },
    config = function()
      require('dashboard').setup({})
      vim.keymap.set('n', '<leader>as', '<cmd>Dashboard<cr>', { silent = true })
    end,
  },
  {
    'wsdjeg/winbar.nvim',
  },
  {
    'nvim-tree/nvim-tree.lua',
    config_before = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.keymap.set('n', '<F3>', '<cmd>NvimTreeToggle<cr>', { silent = true })
      vim.keymap.set('n', '<leader>fo', '<cmd>NvimTreeFindFile<cr>', { silent = true })
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
  },
  {
    'wsdjeg/SpaceVim',
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
    end,
    cmds = { 'Format' },
  },
  {
    'rakr/vim-one',
    config = function()
      vim.cmd([[
      colorscheme one
      ]])
      vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
        pattern = { 'one' },
        group = vim.api.nvim_create_augroup('colorscheme-one', { clear = treu }),
        callback = function()
          vim.cmd([[
	      hi VertSplit guibg=#282c34 guifg=#181A1F
	      hi SPCFloatBorder guibg=#282c34 guifg=#181A1F
	      hi SPCNormalFloat guifg=#abb2bf guibg=#282c34
	      hi clear StatusLineNC
	      hi link StatusLineNC Normal
	      hi link WinSeparator VertSplit
	      ]])
        end,
      })
    end,
    priority = 100,
  },
  {
    'wsdjeg/flygrep.nvim',
    cmds = { 'FlyGrep' },
    config = function()
      require('flygrep').setup()
    end,
    config_before = function()
      vim.keymap.set('n', '<leader>s/', '<cmd>FlyGrep<cr>', { silent = true })
    end,
  },
  {
    'wsdjeg/vim-zettelkasten',
    config_before = function()
      vim.g.zettelkasten_directory = 'D:/me/zettelkasten'
      vim.g.zettelkasten_template_directory = 'D:/me/zettelkasten_template'
    end,
    config = function()
      vim.keymap.set('n', '<leader>mzb', '<cmd>ZkBrowse<cr>', { silent = true })
    end
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
    'nvim-telescope/telescope.nvim',
    cmds = { 'Telescope' },
    depends = {
      {
        'nvim-lua/plenary.nvim',
      },
    },
    config_before = function()
      vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>', { silent = true })
      vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { silent = true })
      vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', { silent = true })
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
})
require('plug').load()
