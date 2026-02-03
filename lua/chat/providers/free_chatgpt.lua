local M = {}

function M.available_models()
  return {
    'gpt-4o-mini',
  }
end

function M.request(requestObj)
  local cmd = {
    'curl',
    '-s',
    'https://free.v36.cm/v1/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. requestObj.api_key,
    '-X',
    'POST',
    '-d',
    vim.json.encode({
      model = requestObj.model,
      messages = requestObj.messages,
      stream = false,
    }),
  }

  vim.system(cmd, { text = true }, function(obj)
    if obj.code ~= 0 then
      requestObj.callback(nil, 'HTTP Error:' .. obj.stderr)
    else
      if obj.stdout then
        local response = vim.trim(obj.stdout)
        if response == '' then
          requestObj.callback(nil, 'empty response')
          return
        end
        local ok, result = pcall(vim.json.decode, response)
        if ok then
          if result.error then
            requestObj.callback(nil, vim.inspect(result.error))
          else
            requestObj.callback(result)
          end
        else
          requestObj.callback(nil, 'JSON parse error: ' .. result)
        end
      end
    end
  end)
end

return M

