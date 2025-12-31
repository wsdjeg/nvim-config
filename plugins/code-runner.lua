return {
  'wsdjeg/code-runner.nvim',
  config = function()
    local function get_c_runner_opt()
      return { '-std=c11', '-xc', '-' }
    end
    local c_runner = {
      exe = 'gcc',
      targetopt = '-o',
      usestdin = true,
      opt = get_c_runner_opt(),
    }
    require('code-runner').setup({
      runners = {
        lua = {
          exe = 'nvim',
          opt = { '-u', 'NONE', '-l', '-' },
          usestdin = true,
          encoding = 'cp936',
          transform = function(line)
            return vim.fn.substitute(line, '\\r$', '', '')
          end,
        },
        c = { c_runner, '#TEMP#' },
        ps = {
          exe = 'powershell.exe',
          opt = { '-Command', '-' },
          usestdin = true,
        },
      },
    })

    -- make sure rooter.nvim plugin is loaded before code-runner

    local function update_clang_flag()
      if vim.fn.filereadable('.clang') == 1 then
        local flags = vim.fn.readfile('.clang')
        local opt = { '-std=c11' }
        for _, v in ipairs(flags) do
          table.insert(opt, v)
        end
        table.insert(opt, '-xc')
        table.insert(opt, '-')
        c_runner.opt = opt
      end
    end

    require('rooter').reg_callback(update_clang_flag)
  end,
  keys = {
    {
      'n',
      '<leader>lr',
      '<cmd>lua require("code-runner").open()<cr>',
      { silent = true, desc = 'open code runner' },
    },
  },
  on_map = { '<leader>lr' },
  dev = true,
  desc = 'async code runner for neovim',
}
