--- provider for https://github.com/chatanywhere/GPT_API_free

local M = {}

local job = require('job')
local sessions = require('chat.sessions')

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

  local jobid = job.start(cmd, {
    on_stdout = requestObj.on_stdout,
    on_exit = requestObj.on_exit,
  })
  sessions.set_session_jobid(requestObj.session, jobid)
end

return M
