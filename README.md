# Eric's Neovim Config

This is my own Neovim configuration for Windows.

- Neovim: v0.11.0
- OS: Windows 11
- Terminal: Windows Terminal

## Installation

```
git clone https://github.com/wsdjeg/nvim-config.git ~/AppData/Local/nvim
```

## Plugins and Key bindings

<!-- nvim-config doc start -->

- git integration in neovim: [git.nvim](https://github.com/wsdjeg/git.nvim)

| key binding  | description             |
| ------------ | ----------------------- |
| `<leader>gs` | display git status      |
| `<leader>gA` | git add all files       |
| `<leader>gc` | git commit              |
| `<leader>gv` | git log of project      |
| `<leader>gV` | git log of current file |
| `<leader>gp` | git push                |
| `<leader>gd` | git diff                |

- [cpicker.nvim](https://github.com/wsdjeg/cpicker.nvim)

- [mru.nvim](https://github.com/wsdjeg/mru.nvim)

- [iedit.nvim](https://github.com/wsdjeg/iedit.nvim)

- [code-runner.nvim](https://github.com/wsdjeg/code-runner.nvim)

- [ctrlg.nvim](https://github.com/wsdjeg/ctrlg.nvim)

- [format.nvim](https://github.com/wsdjeg/format.nvim)

- [bookmarks.nvim](https://github.com/wsdjeg/bookmarks.nvim)

- [logger.nvim](https://github.com/wsdjeg/logger.nvim)

- [statusline.nvim](https://github.com/wsdjeg/statusline.nvim)

- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

- [vim-zettelkasten](https://github.com/wsdjeg/vim-zettelkasten)

| key binding  | description                   |
| ------------ | ----------------------------- |
| `<leader>zb` | open zettelkasten browse      |
| `<leader>zn` | create new zettelkasten note  |
| `<leader>zf` | fuzzy find zettelkasten notes |
| `<leader>zt` | fuzzy find zettelkasten tags  |

- [dashboard-nvim](https://github.com/wsdjeg/dashboard-nvim)

- [nvim-window](https://github.com/yorickpeterse/nvim-window)

- [clever-f.vim](https://github.com/rhysd/clever-f.vim)

- [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc)

- [nvim-surround](https://github.com/kylechui/nvim-surround)

- [music-player.nvim](https://github.com/wsdjeg/music-player.nvim)

| key binding  | description        |
| ------------ | ------------------ |
| `<leader>ms` | stop musics player |
| `<leader>mf` | fuzzy find music   |

- [cmp-path](https://github.com/hrsh7th/cmp-path)

- [cmp-emoji](https://github.com/hrsh7th/cmp-emoji)

- [cmp-dictionary](https://github.com/uga-rosa/cmp-dictionary)

- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

- [flygrep.nvim](https://github.com/wsdjeg/flygrep.nvim)

- [todo.nvim](https://github.com/wsdjeg/todo.nvim)

- [scrollbar.nvim](https://github.com/wsdjeg/scrollbar.nvim)

- [tasks.nvim](https://github.com/wsdjeg/tasks.nvim)

- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

- [picker.nvim](https://github.com/wsdjeg/picker.nvim)

| key binding  | description                        |
| ------------ | ---------------------------------- |
| `<C-p>`      | fuzzy find files in current dir    |
| `<leader>fr` | fuzzy find most recent used files  |
| `<leader>bb` | fuzzy find listed buffers          |
| `<leader>ji` | fuzzy find ctags outline           |
| `<leader>fl` | fuzzy find lines in current buffer |
| `<leader>ff` | fuzzy find picker source           |

- [ctags.nvim](https://github.com/wsdjeg/ctags.nvim)

- [hop.nvim](https://github.com/smoka7/hop.nvim)

- [tabline.nvim](https://github.com/wsdjeg/tabline.nvim)

- [vim-snippets](https://github.com/honza/vim-snippets)

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

- [notify.nvim](https://github.com/wsdjeg/notify.nvim)

- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)

- [context_filetype.vim](https://github.com/Shougo/context_filetype.vim)

- [terminal.nvim](https://github.com/wsdjeg/terminal.nvim)

- [peek.nvim](https://github.com/toppair/peek.nvim)

- [namu.nvim](https://github.com/bassamsdata/namu.nvim)

- [atone.nvim](https://github.com/XXiaoA/atone.nvim)

- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)

- [record-screen.nvim](https://github.com/wsdjeg/record-screen.nvim)

- [job.nvim](https://github.com/wsdjeg/job.nvim)

- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)

- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

- [rooter.nvim](https://github.com/wsdjeg/rooter.nvim)

- [vim-one](https://github.com/rakr/vim-one)

- (Neo)vim chat client: [vim-chat](https://github.com/wsdjeg/vim-chat)

| key binding  | description       |
| ------------ | ----------------- |
| `<leader>ac` | open chat windows |

- [ChineseLinter.vim](https://github.com/wsdjeg/ChineseLinter.vim)

- [nvim-plug](https://github.com/wsdjeg/nvim-plug)

- [record-key.nvim](https://github.com/wsdjeg/record-key.nvim)

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

- [lspkind.nvim](https://github.com/onsails/lspkind.nvim)

- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

| key binding  | description      |
| ------------ | ---------------- |
| `<F3>`       | toggle file tree |
| `<leader>fo` |                  |

- [gitlink.nvim](https://github.com/wsdjeg/gitlink.nvim)

- [aerial.nvim](https://github.com/stevearc/aerial.nvim)

- [vim-signify](https://github.com/mhinz/vim-signify)

- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)

- [repl.nvim](https://github.com/wsdjeg/repl.nvim)

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
<!-- nvim-config doc end -->
