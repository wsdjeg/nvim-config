vim.o.backspace = 'indent,eol,start'
vim.opt.nrformats:remove({ 'octal' })
vim.o.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'
vim.o.fillchars = 'vert:│,fold:·'
vim.o.laststatus = 2
vim.o.tabstop = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.showcmd = false

vim.o.autoindent = true

vim.o.linebreak = true

vim.o.wildmenu = true

vim.o.linebreak = true

vim.o.number = true

vim.o.autoread = true

vim.o.undolevels = 1000

vim.o.writebackup = false

vim.o.matchtime = 0

vim.o.ruler = false

vim.o.showmatch = true

vim.o.showmode = true

vim.o.completeopt = 'menu,menuone,longest'

vim.o.complete = '.,w,b,u,t'

vim.o.pumheight = 15

vim.o.scrolloff = 1
vim.o.sidescrolloff = 5
vim.opt.display = vim.opt.display + { 'lastline' }
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.wildignorecase = true
vim.o.mouse = 'nv'
vim.o.hidden = true
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50
-- don't give ins-completion-menu messages.
vim.opt.shortmess:append('c')
vim.opt.shortmess:append('s')
-- Do not wrap lone lines
vim.o.wrap = false
vim.o.showmode = false
