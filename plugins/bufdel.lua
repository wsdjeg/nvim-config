return {
  'wsdjeg/bufdel.nvim',
  dev = true,
  keys = {
    {
      'n',
      '<leader>bd',
      '<cmd>Bdelete<cr>',
      { silent = true, desc = 'delete current buffer' },
    },
    {
      'n',
      '<leader>bc',
      function()
        require('bufdel').delete(function(buf)
          return vim.fn.buflisted(buf) == 1
            and vim.fn.index(vim.fn.tabpagebuflist(), buf) == -1
            and vim.fn.getbufvar(buf, '&mod') == 0
        end)
      end,
      { silent = true, desc = 'clear saved buffers' },
    },
  },
  on_map = { '<leader>bc', '<leader>bd' },
  desc = 'delete buffer without changing windows layout',
}
