return {
  'wsdjeg/record-screen.nvim',
  config = function()
    require('plugins.record-screen')
  end,
  keys = {
    {
      'n',
      '<F10>',
      '<cmd>RecordScreen -speaker<Cr>',
      { silent = true, desc = 'record screen with speaker' },
    },
    {
      'n',
      '<F12>',
      '<cmd>RecordScreen stop<Cr>',
      { silent = true, desc = 'stop recording' },
    },
  },
  on_map = { '<F10>', '<F12>' },
  cmds = { 'RecordScreen' },
  desc = 'screen recording',
  dev = true,
}
