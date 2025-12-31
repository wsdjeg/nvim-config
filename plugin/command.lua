vim.api.nvim_create_user_command('S', function(opt)
  vim.notify(vim.fn.system(opt.args))
end, { nargs = '*' })
