local M = {}

local available_models = {}

local systemObj

local job = require('job')
local sessions = require('chat.sessions')
local config = require('chat.config')

function M.available_models()
  if #available_models == 0 and not systemObj then
    if config.config.api_key.jdcloud then
      local cmd = {
        'curl',
        '-s',
        '-H',
        'Content-Type: application/json',
        '-H',
        'Authorization: Bearer ' .. config.config.api_key.jdcloud,
        'https://modelservice.jdcloud.com/coding/openai/v1/models',
      }
      systemObj = vim.system(cmd, { text = true }, function(out)
        if out.code == 0 then
          local ok, result = pcall(vim.json.decode, out.stdout)
          if ok and result and result.data and type(result.data) == "table" then
            for _, model in ipairs(result.data) do
              table.insert(available_models, model.id)
            end
          end
        end
      end)
    end
  end
  return available_models
end

function M.request(opt)
  local cmd = {
    'curl',
    '-s',
    'https://modelservice.jdcloud.com/coding/openai/v1/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. config.config.api_key.jdcloud,
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

