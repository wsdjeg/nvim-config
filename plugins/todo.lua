return {
  'wsdjeg/todo.nvim',
  keys = {
    {
      'n',
      '<leader>ao',
      '<cmd>lua require("todo").list()<cr>',
      { silent = true },
    },
  },
  opts = {
    -- @todo support `[TODO]`
    labels = { 'fixme', 'question', 'todo', 'idea', '\\[todo\\]' },
    prefix = '@',
  },
  type = 'rocks',
  dev = true,
  desc = 'project todo manager',
}
