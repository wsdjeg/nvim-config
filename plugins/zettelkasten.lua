return {
  'wsdjeg/zettelkasten.nvim',
  opts = {
    notes_path = 'D:/wsdjeg/my-blog/zettelkasten',
    templates_path = 'D:/wsdjeg/my-blog/zettelkasten_template',
    completion_kind = '[zk]',
  },
  keys = {
    {
      'n',
      '<leader>zb',
      '<cmd>ZkBrowse<cr>',
      { silent = true, desc = 'open zettelkasten browse' },
    },
    {
      'n',
      '<leader>zn',
      '<cmd>ZkNew<cr>',
      { silent = true, desc = 'create new zettelkasten note' },
    },
    {
      'n',
      '<leader>zf',
      '<cmd>Picker zettelkasten<cr>',
      { silent = true, desc = 'fuzzy find zettelkasten notes' },
    },
    {
      'n',
      '<leader>zt',
      '<cmd>Picker zettelkasten_tags<cr>',
      { silent = true, desc = 'fuzzy find zettelkasten tags' },
    },
  },
  dev = true,
  desc = 'a Zettelkasten note taking plugin',
}
