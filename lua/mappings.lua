vim.g.mapleader = ' '
vim.keymap.set(
  'n',
  '<leader>fs',
  '<cmd>w<cr>',
  { silent = true, desc = 'save current buffer' }
)
vim.keymap.set(
  'n',
  '<leader>?',
  '<cmd>Telescope keymaps<cr>',
  { silent = true, desc = 'fuzzy find keymaps' }
)
vim.keymap.set(
  'n',
  '<leader>qq',
  '<cmd>q<cr>',
  { silent = true, desc = ':quit' }
)
vim.keymap.set(
  'n',
  '<leader>qa',
  '<cmd>qa<cr>',
  { silent = true, desc = ':qall' }
)
vim.keymap.set('n', '<leader>bm', function(opt)
  local buf = vim.api.nvim_create_buf(false, true)
  local msg = vim.fn.split(vim.fn.execute('message'), '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, msg)
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
  vim.api.nvim_set_option_value('modified', false, { buf = buf })
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.keymap.set('n', 'q', '<cmd>bd!<cr>', { buffer = buf })
  local win = vim.api.nvim_open_win(buf, true, {
    col = 1,
    row = math.floor(vim.o.lines / 2),
    width = vim.o.columns,
    height = vim.o.lines - math.floor(vim.o.lines / 2),
    focusable = true,
    relative = 'editor',
    title = 'Messages',
    border = 'single',
  })
  vim.api.nvim_set_option_value(
    'winhighlight',
    'NormalFloat:Normal,FloatBorder:WinSeparator',
    { win = win }
  )
  vim.api.nvim_set_option_value('number', true, { win = win })
  vim.api.nvim_set_option_value('relativenumber', false, { win = win })
end, { silent = true, desc = 'open message buffer' })

-- Windows manager
vim.keymap.set(
  'n',
  'so',
  '<cmd>only<cr>',
  { silent = true, desc = 'close other windows' }
)
vim.keymap.set(
  'n',
  'sh',
  '<cmd>split<cr>',
  { silent = true, desc = 'split windows' }
)
vim.keymap.set(
  'n',
  'sv',
  '<cmd>vsplit<cr>',
  { silent = true, desc = 'vsplit windows' }
)
vim.keymap.set('n', 'q', function()
  pcall(vim.cmd.close)
end, { silent = true, desc = ':close' })

-- use alt-h/l to move to previous/next buffer
vim.keymap.set('n', '<M-h>', function()
  require('tabline').jump('prev')
end, { silent = true, desc = 'tabline jump previous' })
vim.keymap.set('n', '<M-l>', function()
  require('tabline').jump('next')
end, { silent = true, desc = 'tabline jump next' })

vim.keymap.set('n', '<M-j>', '<C-d>', { silent = true, desc = 'scroll down' })
vim.keymap.set('n', '<M-k>', '<C-u>', { silent = true, desc = 'scroll up' })

vim.keymap.set(
  'n',
  '<leader><tab>',
  '<cmd>b#<cr>',
  { silent = true, desc = 'switch to b#' }
)

-- LSP mappings

vim.keymap.set(
  'n',
  '<leader>lf',
  vim.lsp.buf.references,
  { silent = true, desc = 'lsp references' }
)
vim.keymap.set(
  'n',
  '<leader>el',
  vim.diagnostic.setqflist,
  { silent = true, desc = 'lsp diagnostic setqflist' }
)
vim.keymap.set(
  'n',
  '<leader>en',
  vim.diagnostic.goto_next,
  { silent = true, desc = 'lsp diagnostic goto_next' }
)
vim.keymap.set(
  'n',
  '<leader>ep',
  vim.diagnostic.goto_prev,
  { silent = true, desc = 'lsp diagnostic goto_prev' }
)

-- Ctrl+Shift+Up/Down to move up and down
vim.keymap.set(
  'n',
  '<C-S-Down>',
  '<cmd>m .+1<cr>==',
  { silent = true, desc = 'move current line down' }
)
vim.keymap.set(
  'n',
  '<C-S-Up>',
  '<cmd>m .-2<cr>==',
  { silent = true, desc = 'move current line up' }
)
vim.keymap.set('i', '<C-S-Down>', '<Esc>:m .+1<cr>==gi', { silent = true })
vim.keymap.set('i', '<C-S-Up>', '<Esc>:m .-2<cr>==gi', { silent = true })
vim.keymap.set('v', '<C-S-Down>', ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set('v', '<C-S-Up>', ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set(
  'n',
  '<C-Down>',
  '<cmd>wincmd j<cr>',
  { silent = true, desc = 'wincmd j' }
)
vim.keymap.set(
  'n',
  '<C-Up>',
  '<cmd>wincmd k<cr>',
  { silent = true, desc = 'wincmd k' }
)
vim.keymap.set(
  'n',
  '<C-Left>',
  '<cmd>wincmd h<cr>',
  { silent = true, desc = 'wincmd h' }
)
vim.keymap.set(
  'n',
  '<C-Right>',
  '<cmd>wincmd l<cr>',
  { silent = true, desc = 'wincmd l' }
)
