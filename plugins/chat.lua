return {
  'wsdjeg/chat.nvim',
  dev = true,
  config = function()
    vim.cmd.source('d:/me/deepseek-api.lua')
    require('chat.log').set_level(0)
  end,
  keys = {
    {
      'n',
      '<leader>ak',
      '<cmd>Chat<Cr>',
      { desc = 'open chat window' },
    },
  },
  desc = 'A lightweight Lua chat plugin for Neovim with AI integration.',
}
