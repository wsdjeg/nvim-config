return {
  'wsdjeg/calendar.nvim',
  dev = true,
  keys = {
    {
      'n',
      '<leader>ac',
      '<cmd>Calendar<cr>',
      { silent = true, desc = 'open calendar' },
    },
  },
}
