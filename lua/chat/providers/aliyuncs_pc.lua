local M = {}

local job = require('job')
local sessions = require('chat.sessions')
local config = require('chat.config')

function M.available_models()
  return {
    'qwen3.5-plus',
    'kimi-k2.5',
    'glm-5',
    'MiniMax-M2.5',
    'qwen3-max-2026-01-23',
    'qwen3-coder-next',
    'qwen3-coder-plus',
    'glm-4.7',
  }
end

function M.request(opt)
  local cmd = {
    'curl',
    '-s',
    'https://coding.dashscope.aliyuncs.com/v1/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. config.config.api_key.aliyuncs_pc,
    '-X',
    'POST',
    '-d',
    '@-',
  }

  local body = vim.json.encode({
    model = sessions.get_session_model(opt.session),
    messages = opt.messages,
    enable_thinking = true,
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
