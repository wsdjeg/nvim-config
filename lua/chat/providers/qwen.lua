local M = {}

local job = require('job')
local sessions = require('chat.sessions')

function M.available_models()
  return {'qwen3-max'}
end

function M.request(requestObj)
  local cmd = {
    'curl',
    '-s',
    'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. requestObj.api_key,
    '-X',
    'POST',
    '-d',
    '@-',
  }

  local body = vim.json.encode({
    model = requestObj.model,
    messages = requestObj.messages,
    stream = true,
    stream_options = { include_usage = true },
    tools = require('chat.tools').available_tools(),
  })

  local jobid = job.start(cmd, {
    on_stdout = requestObj.on_stdout,
    on_stderr = requestObj.on_stderr,
    on_exit = requestObj.on_exit,
  })
  job.send(jobid, body)
  job.send(jobid, nil)
  sessions.set_session_jobid(requestObj.session, jobid)

  return jobid
end

return M

