--=============================================================================
-- init.lua
-- Copyright 2025 Eric Wong
-- Author: Eric Wong < wsdjeg@outlook.com >
-- License: GPLv3
--=============================================================================
pcall(function()
  if vim.fn.sockconnect('tcp', '127.0.0.1:7890') ~= 0 then
    vim.env.http_proxy = 'http://127.0.0.1:7890' -- set http_proxy=http://127.0.0.1:7890
    vim.env.https_proxy = 'http://127.0.0.1:7890' -- set https_proxy=http://127.0.0.1:7890
  end
end)

require('mappings')
require('plugins')
require('autocmds')
require('options')
