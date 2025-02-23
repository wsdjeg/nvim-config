vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>fs', '<cmd>w<cr>', { silent = true })
vim.keymap.set('n', '<leader>qq', '<cmd>q<cr>', { silent = true })
vim.keymap.set('n', '<leader>qa', '<cmd>qa<cr>', { silent = true })
vim.keymap.set('n', 'so', '<cmd>only<cr>', { silent = true })
vim.keymap.set('n', 'sp', '<cmd>split<cr>', { silent = true })
vim.keymap.set('n', 'sv', '<cmd>vsplit<cr>', { silent = true })
vim.keymap.set('n', '<leader>bc', function()
  for i = 1, vim.fn.bufnr('$') do
    if
      vim.fn.buflisted(i) == 1
      and vim.fn.index(vim.fn.tabpagebuflist(), i) == -1
      and vim.fn.getbufvar(i, '&mod') == 0
    then
      vim.cmd(string.format('noautocmd bd %d', i))
    end
  end
  vim.cmd.redrawtabline()
end, { silent = true })
