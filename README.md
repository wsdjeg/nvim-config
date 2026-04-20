# Eric's Neovim Config

This is my own Neovim configuration for Windows.

- Neovim: v0.12.1
- OS: Windows 11
- Terminal: [WezTerm](https://wezterm.org/)
- `<leader>`: `<Space>`
- Plugin Manager: [nvim-plug](https://github.com/wsdjeg/nvim-plug)

## Installation

```
git clone https://github.com/wsdjeg/nvim-config.git ~/AppData/Local/nvim
```

## Plugins and Key bindings

<!-- nvim-config doc start -->

The plugins list and key bindings list are updated via [update-readme.lua](update-readme.lua)

- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)

- [aerial.nvim](https://github.com/stevearc/aerial.nvim)

  | key binding | description          |
  | ----------- | -------------------- |
  | `<F2>`      | open outline windows |

- [altf.nvim](https://github.com/wsdjeg/altf.nvim) - alternate files manager

- [atone.nvim](https://github.com/XXiaoA/atone.nvim)

  | key binding | description             |
  | ----------- | ----------------------- |
  | `<F8>`      | toggle undotree windows |

- [bookmarks.nvim](https://github.com/wsdjeg/bookmarks.nvim) - bookmarks manager for neovim

- [bufdel.nvim](https://github.com/wsdjeg/bufdel.nvim) - delete buffer without changing windows layout

  | key binding  | description           |
  | ------------ | --------------------- |
  | `<leader>bd` | delete current buffer |
  | `<leader>bc` | clear saved buffers   |

- [calendar.nvim](https://github.com/wsdjeg/calendar.nvim) - A lightweight and extensible calendar plugin for Neovim.

  | key binding  | description   |
  | ------------ | ------------- |
  | `<leader>ac` | open calendar |

- [chat.nvim](https://github.com/wsdjeg/chat.nvim) - A lightweight Lua chat plugin for Neovim with AI integration.

  | key binding  | description      |
  | ------------ | ---------------- |
  | `<leader>ak` | open chat window |

- [chineselinter.nvim](https://github.com/wsdjeg/chineselinter.nvim) - Chinese Document Language Standards Checking Tool

- [clever-f.vim](https://github.com/rhysd/clever-f.vim)

- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)

- [cmp-dictionary](https://github.com/uga-rosa/cmp-dictionary)

- [cmp-emoji](https://github.com/hrsh7th/cmp-emoji)

- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)

- [cmp-path](https://github.com/hrsh7th/cmp-path)

- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)

- [code-runner.nvim](https://github.com/wsdjeg/code-runner.nvim) - async code runner for neovim

  | key binding  | description      |
  | ------------ | ---------------- |
  | `<leader>lr` | open code runner |

- [context_filetype.vim](https://github.com/Shougo/context_filetype.vim)

- [cpicker.nvim](https://github.com/wsdjeg/cpicker.nvim) - a lightweight color palette for Neovim

- [ctags.nvim](https://github.com/wsdjeg/ctags.nvim) - ctags integration in neovim

- [ctrlg.nvim](https://github.com/wsdjeg/ctrlg.nvim) - enhanced Ctrl-G status information

  | key binding | description |
  | ----------- | ----------- |
  | `<C-g>`     | ctrlg info  |

- [dashboard-nvim](https://github.com/wsdjeg/dashboard-nvim) - forked dashboard plug

- [flygrep.nvim](https://github.com/wsdjeg/flygrep.nvim) - grep on the fly

  | key binding  | description                   |
  | ------------ | ----------------------------- |
  | `<leader>s/` | open flygrep                  |
  | `<leader>sp` | open flygrep with cursor word |

- [format.nvim](https://github.com/wsdjeg/format.nvim) - asynchronous code formatting plugin for neovim

  | key binding  | description           |
  | ------------ | --------------------- |
  | `<leader>bf` | format current buffer |
  | `<leader>lf` | format code block     |

- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)

- [git.nvim](https://github.com/wsdjeg/git.nvim) - git integration in neovim

  | key binding  | description             |
  | ------------ | ----------------------- |
  | `<leader>gs` | display git status      |
  | `<leader>gA` | git add all files       |
  | `<leader>gc` | git commit              |
  | `<leader>gv` | git log of project      |
  | `<leader>gV` | git log of current file |
  | `<leader>gp` | git push                |
  | `<leader>gd` | git diff                |
  | `<leader>gb` | git diff                |

- [github.nvim](https://github.com/wsdjeg/github.nvim) - github REST api

- [gitlink.nvim](https://github.com/wsdjeg/gitlink.nvim) - Goto/Copy File's Online Link

- [gtags.nvim](https://github.com/wsdjeg/gtags.nvim) - integrates gtags with Neovim

- [helpful.vim](https://github.com/tweekmonster/helpful.vim)

- [hop.nvim](https://github.com/wsdjeg/hop.nvim) - forked hop

  | key binding  | description      |
  | ------------ | ---------------- |
  | `<leader>jl` | hop jump line    |
  | `<leader>jj` | hop jump char    |
  | `<leader>j/` | hop jump pattern |

- [iedit.nvim](https://github.com/wsdjeg/iedit.nvim) - iedit mode for neovim

  | key binding  | description     |
  | ------------ | --------------- |
  | `<leader>se` | open iedit mode |

- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

- [job.nvim](https://github.com/wsdjeg/job.nvim) - neovim job api

- [logevent.nvim](https://github.com/wsdjeg/logevent.nvim)

- [logger.nvim](https://github.com/wsdjeg/logger.nvim) - neovim runtime logger

- [lspkind.nvim](https://github.com/onsails/lspkind.nvim)

- [mru.nvim](https://github.com/wsdjeg/mru.nvim) - mru(most recently used) files

- [music-player.nvim](https://github.com/wsdjeg/music-player.nvim) - neovim music player

  | key binding  | description        |
  | ------------ | ------------------ |
  | `<leader>ms` | stop musics player |
  | `<leader>mf` | fuzzy find music   |

- [neoment](https://github.com/wsdjeg/neoment) - matrix client for neovim

- [notify.nvim](https://github.com/wsdjeg/notify.nvim) - floating notification

- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

- [nvim-plug](https://github.com/wsdjeg/nvim-plug) - neovim plugin manager

- [nvim-surround](https://github.com/kylechui/nvim-surround)

- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

  | key binding  | description      |
  | ------------ | ---------------- |
  | `<F3>`       | toggle file tree |
  | `<leader>fo` |                  |

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

- [nvim-window](https://github.com/yorickpeterse/nvim-window)

- [peek.nvim](https://github.com/toppair/peek.nvim)

- [picker.nvim](https://github.com/wsdjeg/picker.nvim) - a lightweight, high-performance fuzzy finder for Neovim

  | key binding  | description                        |
  | ------------ | ---------------------------------- |
  | `<C-p>`      | fuzzy find files in current dir    |
  | `<leader>fr` | fuzzy find most recent used files  |
  | `<leader>fi` | picker cursor help tag             |
  | `<leader>fh` | picker help tag                    |
  | `<leader>bb` | fuzzy find listed buffers          |
  | `<leader>ji` | fuzzy find ctags outline           |
  | `<leader>fl` | fuzzy find lines in current buffer |
  | `<leader>ff` | fuzzy find picker source           |
  | `<leader>?`  | fuzzy find key mappings            |

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

- [quickfix.nvim](https://github.com/wsdjeg/quickfix.nvim)

- [record-key.nvim](https://github.com/wsdjeg/record-key.nvim) - key binding recording tool

  | key binding | description          |
  | ----------- | -------------------- |
  | `<F9>`      | toggle recording key |

- [record-screen.nvim](https://github.com/wsdjeg/record-screen.nvim) - screen recording

  | key binding | description                |
  | ----------- | -------------------------- |
  | `<F10>`     | record screen with speaker |
  | `<F12>`     | stop recording             |

- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

- [repl.nvim](https://github.com/wsdjeg/repl.nvim) - repl support for neovim

- [rooter.nvim](https://github.com/wsdjeg/rooter.nvim) - Changes Neovim working directory to project root.

  | key binding  | description               |
  | ------------ | ------------------------- |
  | `<leader>fp` | fuzzy find recent project |

- [scratch.nvim](https://github.com/wsdjeg/scratch.nvim)

  | key binding  | description |
  | ------------ | ----------- |
  | `<leader>bs` |             |
  | `<leader>bS` |             |

- [scrollbar.nvim](https://github.com/wsdjeg/scrollbar.nvim) - floating scrollbar

- [smart-ime.nvim](https://github.com/wsdjeg/smart-ime.nvim) - Smart per-buffer IME switching for Neovim.

- [statusline.nvim](https://github.com/wsdjeg/statusline.nvim) - module statusline

- [tabline.nvim](https://github.com/wsdjeg/tabline.nvim) - simple tabline plugin for Neovim

  | key binding  | description           |
  | ------------ | --------------------- |
  | `\1`         | jump to tab 1         |
  | `\2`         | jump to tab 2         |
  | `\3`         | jump to tab 3         |
  | `\4`         | jump to tab 4         |
  | `\5`         | jump to tab 5         |
  | `\6`         | jump to tab 6         |
  | `\7`         | jump to tab 7         |
  | `\8`         | jump to tab 8         |
  | `\9`         | jump to tab 9         |
  | `<leader>bn` | jump to next item     |
  | `<leader>bp` | jump to previous item |

- [tabman.nvim](https://github.com/wsdjeg/tabman.nvim) - A lightweight tab and window manager for Neovim.

  | key binding  | description |
  | ------------ | ----------- |
  | `<leader>tt` |             |

- [tasks.nvim](https://github.com/wsdjeg/tasks.nvim) - tasks manager inspired from vscode

  | key binding  | description      |
  | ------------ | ---------------- |
  | `<leader>ft` | fuzzy find tasks |

- [terminal.nvim](https://github.com/wsdjeg/terminal.nvim) - simple floating terminal plugin for Neovim

  | key binding | description                   |
  | ----------- | ----------------------------- |
  | `<leader>'` | open terminal in current path |
  | `<leader>"` | open terminal in file path    |

- [todo.nvim](https://github.com/wsdjeg/todo.nvim) - project todo manager

  | key binding  | description |
  | ------------ | ----------- |
  | `<leader>ao` |             |

- [toml.nvim](https://github.com/wsdjeg/toml.nvim) - toml file parser

- [utils.nvim](https://github.com/wsdjeg/utils.nvim) - A collection of useful utilities for neovim.

- [vim-chat](https://github.com/wsdjeg/vim-chat) - (Neo)vim chat client

  | key binding  | description       |
  | ------------ | ----------------- |
  | `<leader>aC` | open chat windows |

- [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc)

- [vim-one](https://github.com/rakr/vim-one) - neovim colorscheme

- [vim-signify](https://github.com/mhinz/vim-signify)

- [vim-snippets](https://github.com/honza/vim-snippets)

- [zettelkasten.nvim](https://github.com/wsdjeg/zettelkasten.nvim) - a Zettelkasten note taking plugin

  | key binding  | description                   |
  | ------------ | ----------------------------- |
  | `<leader>zb` | open zettelkasten browse      |
  | `<leader>zn` | create new zettelkasten note  |
  | `<leader>zf` | fuzzy find zettelkasten notes |
  | `<leader>zt` | fuzzy find zettelkasten tags  |

enjoy it :)

<!-- nvim-config doc end -->
