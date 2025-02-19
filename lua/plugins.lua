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
  },
  {
    'wsdjeg/nvim-plug',
    fetch = true,
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
    end
  },
  {
    'wsdjeg/scrollbar.vim',
    events = { 'VimEnter' },
    config = function() end,
  },
  {
    'mhinz/vim-startify',
  },
  {
    'rakr/vim-one',
    config = function()
      vim.cmd('colorscheme one')
    end,
    priority = 100,
  },
  {
    'wsdjeg/flygrep.nvim',
    cmds = { 'FlyGrep' },
    config = function()
      require('flygrep').setup()
    end,
  },
})
require('plug').load()

