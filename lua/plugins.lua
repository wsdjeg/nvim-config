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
