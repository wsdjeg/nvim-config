local bufnr = vim.api.nvim_get_current_buf()
local win = vim.api.nvim_get_current_win()
local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
local params = vim.lsp.util.make_position_params(win)
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

local result = client:request_sync(feature_map.workspace_symbols, {query = ''}, 1000, bufnr)

vim.print(result.result[1])

-- vim.print(client)
