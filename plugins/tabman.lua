return {
  'wsdjeg/tabman.nvim',
  dev = true,
  keys = {
    {
      'n',
      '<leader>tt',
      '',
      {
        silent = true,
        callback = function()
          require('tabman').open({
            filter = function(win)
              local buf = vim.api.nvim_win_get_buf(win)
              return vim.api.nvim_get_option_value('buflisted', { buf = buf })
            end,
          })
        end,
      },
    },
  },
}
