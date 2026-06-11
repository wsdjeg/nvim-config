local M = {}

local job = require('job')
local sessions = require('chat.sessions')
local config = require('chat.config')

function M.available_models()
  return { 'gpt-5.5' }
end

function M.request(opt)
  local cmd = {
    'curl',
    '-s',
    'https://api.94576354.xyz/v1/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. config.config.api_key.sub2api,
    '-X',
    'POST',
    '-d',
    '@-',
  }

  local body = vim.json.encode({
    model = sessions.get_session_model(opt.session),
    messages = opt.messages,
    reasoning_effort = 'high',
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
