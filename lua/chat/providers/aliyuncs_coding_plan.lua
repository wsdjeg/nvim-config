local M = {}

local job = require('job')
local sessions = require('chat.sessions')
local config = require('chat.config')

-- Use Anthropic protocol
M.protocol = 'anthropic'

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

  local system_prompt, anthropic_messages = require('chat.protocol.anthropic').convert_message(opt.messages)

  require('chat.log').debug(vim.inspect(anthropic_messages))

  -- Build request body
  local body = {
    model = sessions.get_session_model(opt.session),
    messages = anthropic_messages,
    max_tokens = 4096,
    thinking = { type = 'enabled' },
    stream = true,
  }

  if system_prompt then
    body.system = system_prompt
  end

  -- Add tools if available
  local tools = require('chat.tools').available_tools()
  if tools and #tools > 0 then
    body.tools = M._convert_tools(tools)
  end

  local cmd = {
    'curl',
    '-s',
    'https://coding.dashscope.aliyuncs.com/apps/anthropic/v1/messages',
    '-H',
    'Content-Type: application/json',
    '-H',
    'x-api-key: ' .. config.config.api_key.aliyuncs_coding_plan,
    '-H',
    'anthropic-version: 2023-06-01',
    '-X',
    'POST',
    '-d',
    '@-',
  }

  local jobid = job.start(cmd, {
    on_stdout = opt.on_stdout,
    on_stderr = opt.on_stderr,
    on_exit = opt.on_exit,
  })
  job.send(jobid, vim.json.encode(body))
  job.send(jobid, nil)
  sessions.set_session_jobid(opt.session, jobid)

  return jobid
end

-- Convert OpenAI tools format to Anthropic format
function M._convert_tools(tools)
  local anthropic_tools = {}
  for _, tool in ipairs(tools) do
    if tool.type == 'function' then
      table.insert(anthropic_tools, {
        name = tool['function'].name,
        description = tool['function'].description,
        input_schema = tool['function'].parameters,
      })
    end
  end
  return anthropic_tools
end

return M
