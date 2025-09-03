# Eric's Neovim Config

> 我的个人配置，仅供参考，不建议直接使用。

## 快捷键列表

更新快捷键列表：

```lua
require('wsdjeg-mappings').update()
```

<!-- wsdjeg key bindings start -->

| 快捷键                                     | 功能描述                                                                                   |
| ------------------------------------------ | ------------------------------------------------------------------------------------------ |
| `<Space>sw`                                | LSP Symbols - Workspace                                                                    |
| `<Space>ss`                                | Jump to LSP symbol                                                                         |
| `<Space>bc`                                | clear saved buffers                                                                        |
| `<Space>bm`                                | open message buffer                                                                        |
| `<Space>fs`                                | save current buffer                                                                        |
| `&`                                        | :help &-default                                                                            |
| `Y`                                        | :help Y-default                                                                            |
| `[<Space>`                                 | Add empty line above cursor                                                                |
| `[B`                                       | :brewind                                                                                   |
| `[b`                                       | :bprevious                                                                                 |
| `[<lt>C-T>`                                | :ptprevious                                                                                |
| `[T`                                       | :trewind                                                                                   |
| `[t`                                       | :tprevious                                                                                 |
| `[A`                                       | :rewind                                                                                    |
| `[a`                                       | :previous                                                                                  |
| `[<lt>C-L>`                                | :lpfile                                                                                    |
| `[L`                                       | :lrewind                                                                                   |
| `[l`                                       | :lprevious                                                                                 |
| `[<lt>C-Q>`                                | :cpfile                                                                                    |
| `[Q`                                       | :crewind                                                                                   |
| `[q`                                       | :cprevious                                                                                 |
| `[D`                                       | Jump to the first diagnostic in the current buffer                                         |
| `[d`                                       | Jump to the previous diagnostic in the current buffer                                      |
| `]<Space>`                                 | Add empty line below cursor                                                                |
| `]B`                                       | :blast                                                                                     |
| `]b`                                       | :bnext                                                                                     |
| `]<lt>C-T>`                                | :ptnext                                                                                    |
| `]T`                                       | :tlast                                                                                     |
| `]t`                                       | :tnext                                                                                     |
| `]A`                                       | :last                                                                                      |
| `]a`                                       | :next                                                                                      |
| `]<lt>C-L>`                                | :lnfile                                                                                    |
| `]L`                                       | :llast                                                                                     |
| `]l`                                       | :lnext                                                                                     |
| `]<lt>C-Q>`                                | :cnfile                                                                                    |
| `]Q`                                       | :clast                                                                                     |
| `]q`                                       | :cnext                                                                                     |
| `]D`                                       | Jump to the last diagnostic in the current buffer                                          |
| `]d`                                       | Jump to the next diagnostic in the current buffer                                          |
| `cS`                                       | Change a surrounding pair, putting replacements on new lines                               |
| `cs`                                       | Change a surrounding pair                                                                  |
| `ds`                                       | Delete a surrounding pair                                                                  |
| `gO`                                       | vim.lsp.buf.document_symbol()                                                              |
| `gri`                                      | vim.lsp.buf.implementation()                                                               |
| `grr`                                      | vim.lsp.buf.references()                                                                   |
| `gra`                                      | vim.lsp.buf.code_action()                                                                  |
| `grn`                                      | vim.lsp.buf.rename()                                                                       |
| `gcc`                                      | Toggle comment line                                                                        |
| `gc`                                       | Toggle comment                                                                             |
| `gx`                                       | Opens filepath or URI under cursor with the system handler (file explorer, web browser, …) |
| `ySS`                                      | Add a surrounding pair around the current line, on new lines (normal mode)                 |
| `yS`                                       | Add a surrounding pair around a motion, on new lines (normal mode)                         |
| `yss`                                      | Add a surrounding pair around the current line (normal mode)                               |
| `ys`                                       | Add a surrounding pair around a motion (normal mode)                                       |
| `<lt>Plug>(nvim-surround-change-line)`     | Change a surrounding pair, putting replacements on new lines                               |
| `<lt>Plug>(nvim-surround-change)`          | Change a surrounding pair                                                                  |
| `<lt>Plug>(nvim-surround-delete)`          | Delete a surrounding pair                                                                  |
| `<lt>Plug>(nvim-surround-normal-cur-line)` | Add a surrounding pair around the current line, on new lines (normal mode)                 |
| `<lt>Plug>(nvim-surround-normal-line)`     | Add a surrounding pair around a motion, on new lines (normal mode)                         |
| `<lt>Plug>(nvim-surround-normal-cur)`      | Add a surrounding pair around the current line (normal mode)                               |
| `<lt>Plug>(nvim-surround-normal)`          | Add a surrounding pair around a motion (normal mode)                                       |
| `<lt>Plug>luasnip-expand-repeat`           | LuaSnip: Repeat last node expansion                                                        |
| `<lt>Plug>luasnip-delete-check`            | LuaSnip: Removes current snippet from jumplist                                             |
| `<lt>C-W><lt>C-D>`                         | Show diagnostics under the cursor                                                          |
| `<lt>C-W>d`                                | Show diagnostics under the cursor                                                          |
| `<lt>C-L>`                                 | :help CTRL-L-default                                                                       |

<!-- wsdjeg key bindings end -->

## 插件列表

更新列表：

```lua
require('wsdjeg-plugins').update()
```

<!-- wsdjeg repos start -->
<a href="https://github.com/wsdjeg/statusline.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=statusline.nvim" />
</a>

<a href="https://github.com/wsdjeg/code-runner.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=code-runner.nvim" />
</a>

<a href="https://github.com/wsdjeg/cpicker.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=cpicker.nvim" />
</a>

<a href="https://github.com/wsdjeg/mru.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=mru.nvim" />
</a>

<a href="https://github.com/wsdjeg/vim-zettelkasten">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=vim-zettelkasten" />
</a>

<a href="https://github.com/wsdjeg/ctrlg.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=ctrlg.nvim" />
</a>

<a href="https://github.com/wsdjeg/dashboard-nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=dashboard-nvim" />
</a>

<a href="https://github.com/wsdjeg/gitlink.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=gitlink.nvim" />
</a>

<a href="https://github.com/wsdjeg/ctags.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=ctags.nvim" />
</a>

<a href="https://github.com/wsdjeg/format.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=format.nvim" />
</a>

<a href="https://github.com/wsdjeg/terminal.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=terminal.nvim" />
</a>

<a href="https://github.com/wsdjeg/flygrep.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=flygrep.nvim" />
</a>

<a href="https://github.com/wsdjeg/vim-chat">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=vim-chat" />
</a>

<a href="https://github.com/wsdjeg/music-player.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=music-player.nvim" />
</a>

<a href="https://github.com/wsdjeg/tasks.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=tasks.nvim" />
</a>

<a href="https://github.com/wsdjeg/git.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=git.nvim" />
</a>

<a href="https://github.com/wsdjeg/ChineseLinter.vim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=ChineseLinter.vim" />
</a>

<a href="https://github.com/wsdjeg/rooter.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=rooter.nvim" />
</a>

<a href="https://github.com/wsdjeg/notify.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=notify.nvim" />
</a>

<a href="https://github.com/wsdjeg/logger.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=logger.nvim" />
</a>

<a href="https://github.com/wsdjeg/job.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=job.nvim" />
</a>

<a href="https://github.com/wsdjeg/iedit.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=iedit.nvim" />
</a>

<a href="https://github.com/wsdjeg/repl.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=repl.nvim" />
</a>

<a href="https://github.com/wsdjeg/scrollbar.vim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=scrollbar.vim" />
</a>

<a href="https://github.com/wsdjeg/record-screen.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=record-screen.nvim" />
</a>

<a href="https://github.com/wsdjeg/todo.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=todo.nvim" />
</a>

<a href="https://github.com/wsdjeg/record-key.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=record-key.nvim" />
</a>

<a href="https://github.com/wsdjeg/tabline.nvim">
  <img align="center" src="https://github-readme-stats.vercel.app/api/pin/?username=wsdjeg&repo=tabline.nvim" />
</a>

<!-- wsdjeg repos end -->
