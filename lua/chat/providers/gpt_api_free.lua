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
    'https://api.chatanywhere.org/v1/chat/completions',
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
      stream = true,
    }),
  }

  vim.system(cmd, {
    text = true,
    stdout = function(err, data)
      requestObj.on_stdout(err, data)
    end,
  }, function(obj)
    if obj.code ~= 0 then
      requestObj.callback(nil, 'HTTP Error:' .. obj.stderr)
    end
  end)
end

return M
