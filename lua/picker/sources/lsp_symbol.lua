local M = {}

local kinds = {}
for k, v in pairs(vim.lsp.protocol.SymbolKind) do
    if type(v) == 'number' then
        kinds[v] = k
    end
end
local opts = {}
local previewer = require('picker.previewer.buffer')
function M.get()
    local bufnr = opts.current_buf
    previewer.buflines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    previewer.filetype = ft
    local win = vim.api.nvim_get_current_win()
    local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
    local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
    local feature_map = {
        document_symbols = 'textDocument/documentSymbol',
        references = 'textDocument/references',
        definitions = 'textDocument/definition',
        type_definitions = 'textDocument/typeDefinition',
        implementations = 'textDocument/implementation',
        workspace_symbols = 'workspace/symbol',
        incoming_calls = 'callHierarchy/incomingCalls',
        outgoing_calls = 'callHierarchy/outgoingCalls',
    }

    local result = client:request_sync(feature_map.document_symbols, params, 5000, bufnr)
    if not result or result.err then
        return {}
    end

    -- {
    --   detail = "",
    --   kind = 13,
    --   name = "bufnr",
    --   range = {
    --     ["end"] = {
    --       character = 44,
    --       line = 0
    --     },
    --     start = {
    --       character = 6,
    --       line = 0
    --     }
    --   },
    --   selectionRange = {
    --     ["end"] = {
    --       character = 11,
    --       line = 0
    --     },
    --     start = {
    --       character = 6,
    --       line = 0
    --     }
    --   }
    -- }

    local items = {}

    for _, symbol in ipairs(result.result) do
        table.insert(items, {
            value = symbol,
            str = string.format('[%s] %s', kinds[symbol.kind], symbol.name),
            highlight = {
                { 0, #kinds[symbol.kind] + 2, 'Comment' },
            },
        })
    end

    return items
end

---@param entry PickerItem
function M.default_action(entry)
    vim.api.nvim_win_set_cursor(
        0,
        { entry.value.range.start.line + 1, entry.value.range.start.character }
    )
end

function M.set(opt)
    opts.current_buf = opt.buf
end

M.preview_win = true

function M.preview(item, win, buf)
    previewer.preview(item.value.range.start.line + 1, win, buf)
end

return M
