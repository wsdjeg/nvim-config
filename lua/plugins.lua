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
    'wsdjeg/mru.nvim',
    config = function()
      require('mru').setup({ enable_cache = true })
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
      { 'Shougo/neosnippet.vim' },
      { 'Shougo/neosnippet-snippets' },
      { 'uga-rosa/cmp-dictionary' },
      { 'onsails/lspkind.nvim' },
      { 'notomo/cmp-neosnippet' },
      {
        'neovim/nvim-lspconfig',
        config = function()
          require('plugins.lspconfig')
        end,
      },
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
      vim.cmd([[
      colorscheme one
      ]])
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
