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
