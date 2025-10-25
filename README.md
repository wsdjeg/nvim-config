# Eric's Neovim Config

This is my own Neovim configuration for Windows.

- Neovim: v0.11.0
- OS: Windows 11
- Terminal: Windows Terminal
- `<leader>`: `<Space>`

## Installation

```
git clone https://github.com/wsdjeg/nvim-config.git ~/AppData/Local/nvim
```

## Plugins and Key bindings

<!-- nvim-config doc start -->

- [hop.nvim](https://github.com/smoka7/hop.nvim)

| key binding  | description   |
| ------------ | ------------- |
| `<leader>jl` | hop jump line |
| `<leader>jj` | hop jump char |

- [music-player.nvim](https://github.com/wsdjeg/music-player.nvim)

| key binding  | description        |
| ------------ | ------------------ |
| `<leader>ms` | stop musics player |
| `<leader>mf` | fuzzy find music   |

- [tabline.nvim](https://github.com/wsdjeg/tabline.nvim)

| key binding | description   |
| ----------- | ------------- |
| `\1`        | jump to tab 1 |
| `\2`        | jump to tab 2 |
| `\3`        | jump to tab 3 |
| `\4`        | jump to tab 4 |
| `\5`        | jump to tab 5 |
| `\6`        | jump to tab 6 |
| `\7`        | jump to tab 7 |
| `\8`        | jump to tab 8 |
| `\9`        | jump to tab 9 |

- [ctrlg.nvim](https://github.com/wsdjeg/ctrlg.nvim)

| key binding | description |
| ----------- | ----------- |
| `<C-g>`     | ctrlg info  |

- [picker.nvim](https://github.com/wsdjeg/picker.nvim)

| key binding  | description                        |
| ------------ | ---------------------------------- |
| `<C-p>`      | fuzzy find files in current dir    |
| `<leader>fr` | fuzzy find most recent used files  |
| `<leader>fi` | picker cursor help tag             |
| `<leader>bb` | fuzzy find listed buffers          |
| `<leader>ji` | fuzzy find ctags outline           |
| `<leader>fl` | fuzzy find lines in current buffer |
| `<leader>ff` | fuzzy find picker source           |

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

- [cmp-dictionary](https://github.com/uga-rosa/cmp-dictionary)

- [vim-signify](https://github.com/mhinz/vim-signify)

- [record-screen.nvim](https://github.com/wsdjeg/record-screen.nvim)

- [lspkind.nvim](https://github.com/onsails/lspkind.nvim)

- [aerial.nvim](https://github.com/stevearc/aerial.nvim)

- [altf.nvim](https://github.com/wsdjeg/altf.nvim)

- [LeaderF](https://github.com/Yggdroot/LeaderF)

- [vim-one](https://github.com/rakr/vim-one)

- [notify.nvim](https://github.com/wsdjeg/notify.nvim)

- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)

- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

| key binding  | description      |
| ------------ | ---------------- |
| `<F3>`       | toggle file tree |
| `<leader>fo` |                  |

- [job.nvim](https://github.com/wsdjeg/job.nvim)

- [nvim-surround](https://github.com/kylechui/nvim-surround)

- [nvim-plug](https://github.com/wsdjeg/nvim-plug)

- [scrollbar.nvim](https://github.com/wsdjeg/scrollbar.nvim)

- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

- [atone.nvim](https://github.com/XXiaoA/atone.nvim)

| key binding | description             |
| ----------- | ----------------------- |
| `<F8>`      | toggle undotree windows |

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

- [zettelkasten.nvim](https://github.com/wsdjeg/zettelkasten.nvim)

| key binding  | description                   |
| ------------ | ----------------------------- |
| `<leader>zb` | open zettelkasten browse      |
| `<leader>zn` | create new zettelkasten note  |
| `<leader>zf` | fuzzy find zettelkasten notes |
| `<leader>zt` | fuzzy find zettelkasten tags  |

- [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc)

- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

- [mru.nvim](https://github.com/wsdjeg/mru.nvim)

- [bookmarks.nvim](https://github.com/wsdjeg/bookmarks.nvim)

- [todo.nvim](https://github.com/wsdjeg/todo.nvim)

| key binding  | description |
| ------------ | ----------- |
| `<leader>ao` |             |

- [ctags.nvim](https://github.com/wsdjeg/ctags.nvim)

- [namu.nvim](https://github.com/bassamsdata/namu.nvim)

- [logger.nvim](https://github.com/wsdjeg/logger.nvim)

- [clever-f.vim](https://github.com/rhysd/clever-f.vim)

- [terminal.nvim](https://github.com/wsdjeg/terminal.nvim)

| key binding | description                   |
| ----------- | ----------------------------- |
| `<leader>'` | open terminal in current path |
| `<leader>"` | open terminal in file path    |

- [snacks.nvim](https://github.com/folke/snacks.nvim)

- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)

- [gitlink.nvim](https://github.com/wsdjeg/gitlink.nvim)

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

- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)

- [rooter.nvim](https://github.com/wsdjeg/rooter.nvim)

| key binding  | description               |
| ------------ | ------------------------- |
| `<leader>fp` | fuzzy find recent project |

- [repl.nvim](https://github.com/wsdjeg/repl.nvim)

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)

- (Neo)vim chat client: [vim-chat](https://github.com/wsdjeg/vim-chat)

| key binding  | description       |
| ------------ | ----------------- |
| `<leader>ac` | open chat windows |

- [cpicker.nvim](https://github.com/wsdjeg/cpicker.nvim)

- [code-runner.nvim](https://github.com/wsdjeg/code-runner.nvim)

- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

- [format.nvim](https://github.com/wsdjeg/format.nvim)

- [ChineseLinter.vim](https://github.com/wsdjeg/ChineseLinter.vim)

- [cmp-path](https://github.com/hrsh7th/cmp-path)

- [peek.nvim](https://github.com/toppair/peek.nvim)

- [statusline.nvim](https://github.com/wsdjeg/statusline.nvim)

- [iedit.nvim](https://github.com/wsdjeg/iedit.nvim)

- [dashboard-nvim](https://github.com/wsdjeg/dashboard-nvim)

- [tasks.nvim](https://github.com/wsdjeg/tasks.nvim)

- [nvim-window](https://github.com/yorickpeterse/nvim-window)

- [vim-snippets](https://github.com/honza/vim-snippets)

- [record-key.nvim](https://github.com/wsdjeg/record-key.nvim)

- [flygrep.nvim](https://github.com/wsdjeg/flygrep.nvim)

- [context_filetype.vim](https://github.com/Shougo/context_filetype.vim)

- [cmp-emoji](https://github.com/hrsh7th/cmp-emoji)
<!-- nvim-config doc end -->
