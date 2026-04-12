vim.api.nvim_create_user_command('S', function(opt)
  vim.notify(vim.fn.system(opt.args))
end, { nargs = '*' })

vim.api.nvim_create_user_command('LogClear', function()
  require('logger').clearRuntimeLog()
end, { nargs = '*' })
