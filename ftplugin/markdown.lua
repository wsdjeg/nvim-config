vim.keymap.set('n', '<leader>lr', function()
  local cf = vim.fn['context_filetype#get']()

  if cf.filetype ~= 'markdown' then
    local runner = require('code-runner').get(cf.filetype)
    runner['usestdin'] = true
    runner['range'] = { cf['range'][1][1], cf['range'][2][1] }
    require('code-runner').open(runner)
  end
end, { silent = true, buffer = true })
vim.keymap.set('n', '<leader>bf', function()
  local cf = vim.fn['context_filetype#get']()

  if cf.filetype ~= 'markdown' then
    local command = vim.fn.printf(
      '%s,%sFormat! %s',
      cf.range[1][1],
      cf.range[2][1],
      cf.filetype
    )
    vim.cmd(command)
  else
    vim.cmd('Format')
  end
end, { silent = true, buffer = true })
