return {
  'wsdjeg/calendar.nvim',
  dev = true,
  -- cmds = { 'Calendar' },
  keys = {
    {
      'n',
      '<leader>ac',
      '<cmd>Calendar<cr>',
      { silent = true, desc = 'open calendar' },
    },
  },
  opts = {
    locale = 'zh-CN',
  },
}
