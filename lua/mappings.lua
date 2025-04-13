vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>fs', '<cmd>w<cr>', { silent = true })
vim.keymap.set('n', '<leader>qq', '<cmd>q<cr>', { silent = true })
vim.keymap.set('n', '<leader>qa', '<cmd>qa<cr>', { silent = true })

-- Windows manager
vim.keymap.set('n', 'so', '<cmd>only<cr>', { silent = true })
vim.keymap.set('n', 'sh', '<cmd>split<cr>', { silent = true })
vim.keymap.set('n', 'sv', '<cmd>vsplit<cr>', { silent = true })
vim.keymap.set('n', 'q', function()
    vim.cmd.quit()
end, { silent = true })

-- Buffer manager
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
vim.keymap.set('n', '<leader>bd', function()
    vim.cmd('bd')
    vim.cmd.redrawtabline()
end, { silent = true })
vim.keymap.set('n', '<leader><tab>', '<cmd>b#<cr>', { silent = true })

-- Ctrl+Shift+Up/Down to move up and down
vim.keymap.set('n', '<C-S-Down>', '<cmd>m .+1<cr>==', { silent = true })
vim.keymap.set('n', '<C-S-Up>', '<cmd>m .-2<cr>==', { silent = true })
vim.keymap.set('i', '<C-S-Down>', '<Esc>:m .+1<cr>==gi', { silent = true })
vim.keymap.set('i', '<C-S-Up>', '<Esc>:m .-2<cr>==gi', { silent = true })
vim.keymap.set('v', '<C-S-Down>', ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set('v', '<C-S-Up>', ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set('n', '<C-Down>', '<cmd>wincmd j<cr>', { silent = true })
vim.keymap.set('n', '<C-Up>', '<cmd>wincmd k<cr>', { silent = true })
vim.keymap.set('n', '<C-Left>', '<cmd>wincmd h<cr>', { silent = true })
vim.keymap.set('n', '<C-Right>', '<cmd>wincmd l<cr>', { silent = true })
