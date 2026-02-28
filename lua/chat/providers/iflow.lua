local M = {}

local job = require('job')
local sessions = require('chat.sessions')
local config = require('chat.config')

function M.available_models()
  return {
    'iflow-rome-30ba3b',
    'qwen3-coder-plus',
    'qwen3-max',
    'qwen3-vl-plus',
    'kimi-k2-0905',
    'qwen3-max-preview',
    'glm-4.6',
    'kimi-k2',
    'deepseek-v3.2',
    'deepseek-r1',
    'deepseek-v3',
    'qwen3-32b',
    'qwen3-235b-a22b-thinking-2507',
    'qwen3-235b-a22b-instruct',
    'qwen3-235b',
  }
end

function M.request(opt)
  local cmd = {
    'curl',
    '-s',
    'https://apis.iflow.cn/v1/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. config.config.api_key.iflow,
    '-X',
    'POST',
    '-d',
    '@-',
  }

  local body = vim.json.encode({
    model = sessions.get_session_model(opt.session),
    messages = opt.messages,
    stream = true,
    chat_template_kwargs = {
      enable_thinking = true,
    },
    stream_options = { include_usage = true },
    tools = require('chat.tools').available_tools(),
  })

  local function fix_done_stdout(id, data)
    for idx, line in ipairs(data) do
      if
        line:match('"finish_reason":"')
        and line:match(',"usage":{"prompt_tokens"')
      then
        table.insert(data, idx + 1, '')
        table.insert(data, idx + 1, 'data: [DONE]')
        table.insert(data, idx + 1, '')
      end
    end
    opt.on_stdout(id, data)
  end

  local jobid = job.start(cmd, {
    on_stdout = fix_done_stdout,
    on_stderr = opt.on_stderr,
    on_exit = opt.on_exit,
  })
  job.send(jobid, body)
  job.send(jobid, nil)
  sessions.set_session_jobid(opt.session, jobid)

  return jobid
end

return M
