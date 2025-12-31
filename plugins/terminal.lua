return {
  'wsdjeg/terminal.nvim',
  keys = {
    {
      'n',
      "<leader>'",
      '<cmd>lua require("terminal").open()<cr>',
      { silent = true, desc = 'open terminal in current path' },
    },
    {
      'n',
      '<leader>"',
      '<cmd>lua require("terminal").open(vim.fn.expand("%:p:h"))<cr>',
      { silent = true, desc = 'open terminal in file path' },
    },
  },
  opts = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    picker = {
      highlight = {
        --  [25768   ] ✓ { "cmd.exe", "/s", "/c", '"cmd.exe"' } (~\AppData\Local\nvim) buf:2
        --   jobpid   status            cmd                             cwd            bufnr
        jobpid = 'Number',
        status_ok = 'DiagnosticOk',
        status_error = 'DiagnosticError',
        cmd = 'String',
        cwd = 'Label',
        buffer = 'Number',
      },
    },
  },
  dev = true,
  desc = 'simple floating terminal plugin for Neovim',
}
