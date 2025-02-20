local augroup = vim.api.nvim_create_augroup('wsdjeg', {clear = true})

local create_autocmd = vim.api.nvim_create_autocmd
 create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = augroup,
    callback = function(_)
      require('mkdir').create_current()
    end,
  })



