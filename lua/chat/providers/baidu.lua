local M = {}

local available_models = {}

local job = require('job')
local sessions = require('chat.sessions')
local config = require('chat.config')

function M.available_models()
  if #available_models == 0 then
    if config.config.api_key.baidu then
      local cmd = {
        'curl',
        '-s',
        '-H',
        'Content-Type: application/json',
        '-H',
        'Authorization: Bearer ' .. config.config.api_key.baidu,
        'https://qianfan.baidubce.com/v2/models',
      }
      local systemObj = vim.system(cmd):wait()
      if systemObj.code == 0 then
        local ok, result = pcall(vim.json.decode, systemObj.stdout)
        if ok then
          for _, model in ipairs(result.data) do
            table.insert(available_models, model.id)
          end
        end
      end
    end
  end
  return available_models
end

function M.request(opt)
  local cmd = {
    'curl',
    '-s',
    'https://qianfan.baidubce.com/v2/chat/completions',
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: Bearer ' .. config.config.api_key.baidu,
    '-X',
    'POST',
    '-d',
    '@-',
  }

  local body = vim.json.encode({
    model = sessions.get_session_model(opt.session),
    messages = opt.messages,
    thinking = {
      type = 'enabled',
    },
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


