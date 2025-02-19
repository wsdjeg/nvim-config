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
    end,
  },
  {
    'wsdjeg/nvim-plug',
    fetch = true,
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('cmp').setup()
    end,
    depends = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
    },
  },
  {
    'wsdjeg/scrollbar.vim',
    events = { 'VimEnter' },
    config = function() end,
  },
  {
    'nvimdev/dashboard-nvim',
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
      hi VertSplit guibg=#282c34 guifg=#181A1F
      hi SPCFloatBorder guibg=#282c34 guifg=#181A1F
      hi SPCNormalFloat guifg=#abb2bf guibg=#282c34
      hi clear StatusLineNC
      hi link StatusLineNC Normal
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
})
require('plug').load()
