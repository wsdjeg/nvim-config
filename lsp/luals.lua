local lua_rtp = vim.split(package.path, ';')
table.insert(lua_rtp, 'lua/?.lua')
table.insert(lua_rtp, 'lua/?/init.lua')
local plug = require('plug')
local library = {'${3rd}/luv/library', vim.env.VIMRUNTIME}

for _, v in ipairs(plug.get()) do
  if v.dev_path and v.dev_path:match('wsdjeg') then
    table.insert(library, v.dev_path)
  end
end

return {
  cmd = {
    'lua-language-server',
    '--logpath',
    'C:\\Users\\wsdjeg\\.cache\\lua-language-server',
    '--metapath',
    'C:\\Users\\wsdjeg\\.cache\\lua-language-server\\meta',
  },
  root_markers = { '.stylua.toml' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        path = lua_rtp,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
        -- disable = { 'need-check-nil' },
      },
      hint = { enable = true, setType = true },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = library,
        preloadFileSize = 2000,
        ignoreDir = { 'bundle' },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
