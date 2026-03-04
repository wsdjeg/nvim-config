--- provider for https://github.com/chatanywhere/GPT_API_free

local M = {}

local job = require('job')
local sessions = require('chat.sessions')
local config = require('chat.config')

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

function M.request(opt)
  local cmd = {
    'curl',
    '-s',
    'https://free.v36.cm/v1/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. config.config.api_key.gpt_api_free,
    '-X',
    'POST',
    '-d',
    '@-',
  }

  local body = vim.json.encode({
    model = sessions.get_session_model(opt.session),
    messages = opt.messages,
    stream = true,
    stream_options = { include_usage = true },
    tools = require('chat.tools').available_tools(),
  })

  local jobid = job.start(cmd, {
    on_stdout = opt.on_stdout,
    on_stderr = opt.on_stderr,
    on_exit = opt.on_exit,
  })
  job.send(jobid, body)
  job.send(jobid, nil)
  sessions.set_session_jobid(opt.session, jobid)

  return jobid
end

return M
