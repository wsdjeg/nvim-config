return {
  'wsdjeg/chat.nvim',
  dev = true,
  config = function()
    vim.cmd.source('d:/me/deepseek-api.lua')
  end,
  desc = 'A lightweight Lua chat plugin for Neovim with AI integration.'
}
