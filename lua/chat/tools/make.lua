local M = {}

local config = require('chat.config')
local util = require('chat.util')
local job = require('job')

-- Cache make availability check
local make_available = nil
local function is_make_available()
  if make_available == nil then
    make_available = vim.fn.executable('make') == 1
  end
  return make_available
end

---@class ChatToolsMakeAction
---@field target? string Make target to run (e.g., "test", "build")
---@field args? string[] Additional arguments for make
---@field directory? string Directory to run make in (default: ctx.cwd)

---@param action ChatToolsMakeAction
---@param ctx ChatToolContext
function M.make(action, ctx)
  -- Security check for ctx.cwd
  local is_allowed_path = false

  if type(config.config.allowed_path) == 'table' then
    for _, v in ipairs(config.config.allowed_path) do
      if type(v) == 'string' and #v > 0 then
        if vim.startswith(ctx.cwd, vim.fs.normalize(v)) then
          is_allowed_path = true
          break
        end
      end
    end
  elseif
    type(config.config.allowed_path) == 'string'
    and #config.config.allowed_path > 0
  then
    is_allowed_path =
      vim.startswith(ctx.cwd, vim.fs.normalize(config.config.allowed_path))
  end

  if not is_allowed_path then
    return {
      error = 'Cannot run make in non-allowed path.',
    }
  end

  if not is_make_available() then
    return {
      error = 'make is not installed or not in PATH.',
    }
  end

  -- Build make command
  local cmd = { 'make' }

  -- Add target if specified
  if action.target and type(action.target) == 'string' and #action.target > 0 then
    table.insert(cmd, action.target)
  end

  -- Add additional arguments
  if action.args and type(action.args) == 'table' then
    for _, arg in ipairs(action.args) do
      if type(arg) == 'string' and #arg > 0 then
        table.insert(cmd, arg)
      end
    end
  end

  -- Resolve working directory
  local work_dir = ctx.cwd
  if action.directory and type(action.directory) == 'string' then
    work_dir = util.resolve(action.directory, ctx.cwd)
    
    -- Security: ensure work_dir is within ctx.cwd
    if not vim.startswith(vim.fs.normalize(work_dir), vim.fs.normalize(ctx.cwd)) then
      return {
        error = 'Cannot access directory outside working directory.',
      }
    end
  end

  local stdout = {}
  local stderr = {}

  local jobid = job.start(cmd, {
    cwd = work_dir,
    on_stdout = function(_, data)
      vim.list_extend(stdout, data)
    end,
    on_stderr = function(_, data)
      vim.list_extend(stderr, data)
    end,
    on_exit = function(id, code, signal)
      if signal ~= 0 then
        ctx.callback({
          error = string.format('Make cancelled (signal: %d)', signal),
          jobid = id,
        })
        return
      end

      local output = table.concat(stdout, '\n')
      local error_output = table.concat(stderr, '\n')

      -- Combine output
      local full_output = output
      if #error_output > 0 then
        full_output = full_output .. '\n' .. error_output
      end

      local target_desc = action.target or 'default target'
      local summary = string.format(
        'Make %s: %s (exit code: %d)\n\n',
        target_desc,
        code == 0 and '✓ Success' or '✗ Failed',
        code
      )

      ctx.callback({
        content = summary .. (full_output ~= '' and full_output or 'No output.'),
        exit_code = code,
        jobid = id,
      })
    end,
  })

  if jobid > 0 then
    return { jobid = jobid }
  end
end

function M.scheme()
  return {
    type = 'function',
    ['function'] = {
      name = 'make',
      description = [[
Run make targets and return results.

USAGE:
- @make                           # Run default target
- @make target="test"             # Run make test
- @make target="build"            # Run make build
- @make target="test" args=["-j4"]  # Run with options
- @make directory="./subproject"  # Run in subdirectory

EXAMPLES:
- Run tests: @make target="test"
- Build with 4 jobs: @make target="build" args=["-j4"]
- Clean and rebuild: @make target="clean" args=["all"]

OUTPUT:
Returns make command output with exit code and status.
      ]],
      parameters = {
        type = 'object',
        properties = {
          target = {
            type = 'string',
            description = 'Make target to run (e.g., "test", "build", "clean")',
          },
          args = {
            type = 'array',
            items = { type = 'string' },
            description = 'Additional arguments for make (e.g., ["-j4", "VERBOSE=1"])',
          },
          directory = {
            type = 'string',
            description = 'Directory to run make in (default: current working directory)',
          },
        },
        required = {},
      },
    },
  }
end

function M.info(action, ctx)
  local ok, args = pcall(vim.json.decode, action)
  if ok then
    local parts = { 'make' }
    if args.target then
      table.insert(parts, string.format('target="%s"', args.target))
    end
    if args.args and #args.args > 0 then
      table.insert(parts, string.format('args=%s', vim.json.encode(args.args)))
    end
    if args.directory then
      table.insert(parts, string.format('directory="%s"', args.directory))
    end
    return table.concat(parts, ' ')
  end
  return 'make'
end

return M

