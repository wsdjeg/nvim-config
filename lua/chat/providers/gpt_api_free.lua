--- provider for https://github.com/chatanywhere/GPT_API_free

local M = {}

function M.available_models()
  -- 免费版支持gpt-5.2, gpt-5.1, gpt-5, gpt-4o，gpt-4.1一天5次；支持deepseek-r1, deepseek-v3, deepseek-v3-2-exp一天30次，支持gpt-4o-mini，gpt-3.5-turbo，gpt-4.1-mini，gpt-4.1-nano, gpt-5-mini，gpt-5-nano一天200次
  return {
    'gpt-5.2',
    'gpt-5.1',
    'gpt-5',
    'gpt-4o',
    'gpt-4.1',
    'deepseek-r1',
    'deepseek-v3',
    'deepseek-v3-2-exp',
    'gpt-4o-mini',
    'gpt-3.5-turbo',
    'gpt-4.1-mini',
    'gpt-4.1-nano',
    'gpt-5-mini',
    'gpt-5-nano',
  }
end

function M.request(requestObj)
  local cmd = {
    'curl',
    '-s',
    'api.chatanywhere.tech/v1/chat/completions',
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
