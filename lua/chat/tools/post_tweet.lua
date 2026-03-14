local M = {}

local config = require('chat.config')

-- Cache curl availability check
local curl_available = nil
local function is_curl_available()
  if curl_available == nil then
    local curl_check = vim.fn.system({ 'curl', '--version' })
    curl_available = vim.v.shell_error == 0
  end
  return curl_available
end

-- ============ OAuth 1.0a Helper Functions ============

local function generate_nonce()
  -- Generate random string for OAuth nonce
  local chars =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  local nonce = {}
  for i = 1, 32 do
    local rand = math.random(1, #chars)
    table.insert(nonce, chars:sub(rand, rand))
  end
  return table.concat(nonce)
end

local function generate_timestamp()
  return tostring(os.time())
end

local function percent_encode(str)
  -- OAuth percent encoding (RFC 3986)
  return str:gsub('[^%w%-._~]', function(c)
    return string.format('%%%02X', string.byte(c))
  end)
end

-- Detect available HMAC-SHA1 implementation
local hmac_impl = nil

-- Pure Lua SHA1 implementation (fallback)
local function sha1_lua(msg)
  -- Simplified SHA1 implementation for OAuth
  -- Based on RFC 3174
  local bit = bit or bit32 or require('bit')

  local function rol(num, bits)
    return bit.bor(bit.lshift(num, bits), bit.rshift(num, 32 - bits))
  end

  local function to_bytes(num, len)
    local bytes = {}
    for i = len, 1, -1 do
      bytes[i] = bit.band(num, 0xFF)
      num = bit.rshift(num, 8)
    end
    return bytes
  end

  -- Initialize SHA1 state
  local h0, h1, h2, h3, h4 =
    0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476, 0xC3D2E1F0

  -- Pre-processing: adding padding bits
  local msg_len = #msg
  local msg_bits = msg_len * 8
  msg = msg .. string.char(0x80)
  while (#msg % 64) ~= 56 do
    msg = msg .. string.char(0)
  end

  -- Append original length in bits as 64-bit big-endian
  msg = msg .. string.char(0, 0, 0, 0)
  for _, b in ipairs(to_bytes(msg_bits, 4)) do
    msg = msg .. string.char(b)
  end

  -- Process each 512-bit chunk
  for i = 1, #msg, 64 do
    local chunk = msg:sub(i, i + 63)
    local w = {}

    -- Break chunk into sixteen 32-bit big-endian words
    for j = 0, 15 do
      w[j] = bit.bor(
        bit.lshift(chunk:byte(j * 4 + 1), 24),
        bit.lshift(chunk:byte(j * 4 + 2), 16),
        bit.lshift(chunk:byte(j * 4 + 3), 8),
        chunk:byte(j * 4 + 4)
      )
    end

    -- Extend the sixteen 32-bit words into eighty 32-bit words
    for j = 16, 79 do
      w[j] = rol(bit.bxor(w[j - 3], w[j - 8], w[j - 14], w[j - 16]), 1)
    end

    -- Initialize working variables
    local a, b, c, d, e = h0, h1, h2, h3, h4

    -- Main loop
    for j = 0, 79 do
      local f, k
      if j < 20 then
        f = bit.bor(bit.band(b, c), bit.band(bit.bnot(b), d))
        k = 0x5A827999
      elseif j < 40 then
        f = bit.bxor(b, c, d)
        k = 0x6ED9EBA1
      elseif j < 60 then
        f = bit.bor(bit.band(b, c), bit.band(b, d), bit.band(c, d))
        k = 0x8F1BBCDC
      else
        f = bit.bxor(b, c, d)
        k = 0xCA62C1D6
      end

      local temp = bit.band(rol(a, 5) + f + e + k + w[j], 0xFFFFFFFF)
      e = d
      d = c
      c = rol(b, 30)
      b = a
      a = temp
    end

    -- Add this chunk's hash to result so far
    h0 = bit.band(h0 + a, 0xFFFFFFFF)
    h1 = bit.band(h1 + b, 0xFFFFFFFF)
    h2 = bit.band(h2 + c, 0xFFFFFFFF)
    h3 = bit.band(h3 + d, 0xFFFFFFFF)
    h4 = bit.band(h4 + e, 0xFFFFFFFF)
  end

  -- Produce the final hash value (big-endian)
  local result = {}
  for _, h in ipairs({ h0, h1, h2, h3, h4 }) do
    for _, b in ipairs(to_bytes(h, 4)) do
      table.insert(result, string.char(b))
    end
  end

  return table.concat(result)
end

local function base64_encode(data)
  -- Base64 encoding in pure Lua
  local b64chars =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  local result = {}

  for i = 1, #data, 3 do
    local b1, b2, b3 = data:byte(i, i + 2)
    b2 = b2 or 0
    b3 = b3 or 0

    local n = bit.bor(bit.lshift(b1, 16), bit.lshift(b2, 8), b3)

    table.insert(
      result,
      b64chars:sub(
        bit.band(bit.rshift(n, 18), 0x3F) + 1,
        bit.band(bit.rshift(n, 18), 0x3F) + 1
      )
    )
    table.insert(
      result,
      b64chars:sub(
        bit.band(bit.rshift(n, 12), 0x3F) + 1,
        bit.band(bit.rshift(n, 12), 0x3F) + 1
      )
    )
    table.insert(
      result,
      b64chars:sub(
        bit.band(bit.rshift(n, 6), 0x3F) + 1,
        bit.band(bit.rshift(n, 6), 0x3F) + 1
      )
    )
    table.insert(
      result,
      b64chars:sub(bit.band(n, 0x3F) + 1, bit.band(n, 0x3F) + 1)
    )
  end

  -- Add padding
  local padding = (3 - #data % 3) % 3
  for i = 1, padding do
    result[#result - i + 1] = '='
  end

  return table.concat(result)
end

local function hmac_sha1_lua(key, data)
  -- HMAC-SHA1 implementation (RFC 2104)
  local blocksize = 64 -- 64 bytes for SHA-1

  -- Keys longer than blocksize are shortened
  if #key > blocksize then
    key = sha1_lua(key)
  end

  -- Keys shorter than blocksize are padded
  while #key < blocksize do
    key = key .. string.char(0)
  end

  -- Create o_key_pad and i_key_pad
  local o_key_pad = {}
  local i_key_pad = {}

  for i = 1, blocksize do
    o_key_pad[i] = string.char(bit.bxor(key:byte(i), 0x5C))
    i_key_pad[i] = string.char(bit.bxor(key:byte(i), 0x36))
  end

  o_key_pad = table.concat(o_key_pad)
  i_key_pad = table.concat(i_key_pad)

  -- Return Base64 encoded HMAC
  local inner_hash = sha1_lua(i_key_pad .. data)
  local outer_hash = sha1_lua(o_key_pad .. inner_hash)

  -- Base64 encode
  return base64_encode(outer_hash)
end

local function hmac_sha1(key, data)
  return hmac_sha1_lua(key, data)
end

local function build_signature_base_string(method, url, params)
  -- Build the signature base string for OAuth 1.0a
  -- Format: METHOD&URL_ENCODED&PARAMS_ENCODED

  -- Sort parameters alphabetically
  local sorted_params = {}
  for key, value in pairs(params) do
    table.insert(
      sorted_params,
      percent_encode(key) .. '=' .. percent_encode(value)
    )
  end
  table.sort(sorted_params)

  local params_string = table.concat(sorted_params, '&')

  return string.format(
    '%s&%s&%s',
    method,
    percent_encode(url),
    percent_encode(params_string)
  )
end

local function generate_oauth_signature(
  method,
  url,
  params,
  consumer_secret,
  token_secret
)
  local base_string = build_signature_base_string(method, url, params)
  local signing_key = percent_encode(consumer_secret)
    .. '&'
    .. percent_encode(token_secret)
  return hmac_sha1(signing_key, base_string)
end

local function build_oauth_header(method, url, body_params, credentials)
  -- Build OAuth 1.0a Authorization header
  local oauth_params = {
    oauth_consumer_key = credentials.consumer_key,
    oauth_nonce = generate_nonce(),
    oauth_signature_method = 'HMAC-SHA1',
    oauth_timestamp = generate_timestamp(),
    oauth_token = credentials.access_token,
    oauth_version = '1.0',
  }

  -- Merge oauth params and body params for signature generation
  local all_params = {}
  for k, v in pairs(oauth_params) do
    all_params[k] = v
  end
  for k, v in pairs(body_params) do
    all_params[k] = v
  end

  -- Generate signature
  oauth_params.oauth_signature = generate_oauth_signature(
    method,
    url,
    all_params,
    credentials.consumer_secret,
    credentials.access_token_secret
  )

  -- Build Authorization header value
  local header_parts = {}
  for key, value in pairs(oauth_params) do
    table.insert(
      header_parts,
      string.format('%s="%s"', key, percent_encode(value))
    )
  end
  table.sort(header_parts) -- Sort for consistency

  return 'OAuth ' .. table.concat(header_parts, ', ')
end

-- ============ End OAuth 1.0a Helpers ============

---@class ChatToolsPostTweetAction
---@field text string The tweet text content
---@field media_ids? string[] Optional media attachment IDs

---@param action ChatToolsPostTweetAction
---@param ctx ChatToolContext
function M.post_tweet(action, ctx)
  -- Parameter validation
  if
    not action.text
    or type(action.text) ~= 'string'
    or action.text == ''
  then
    return {
      error = 'Tweet text is required and must be a non-empty string.',
    }
  end

  -- Check tweet length (Twitter's limit is 280 characters for most languages)
  if #action.text > 280 then
    return {
      error = string.format(
        'Tweet is too long: %d characters. Maximum allowed is 280 characters.',
        #action.text
      ),
    }
  end

  -- Check if curl is available
  if not is_curl_available() then
    return {
      error = 'curl is not installed or not in PATH. Please install curl first.',
    }
  end

  -- Get OAuth 1.0a credentials from config
  local api_keys = config.config.api_key or {}
  local consumer_key = api_keys.twitter_consumer_key
  local consumer_secret = api_keys.twitter_consumer_secret
  local access_token = api_keys.twitter_access_token
  local access_token_secret = api_keys.twitter_access_token_secret

  -- Check if all required credentials are present
  if
    not consumer_key
    or not consumer_secret
    or not access_token
    or not access_token_secret
  then
    return {
      error = [[
Twitter OAuth 1.0a credentials not configured.

Posting tweets requires OAuth 1.0a User Context authentication.
Please add your Twitter API credentials to your chat.nvim config:

require('chat').setup({
  api_key = {
    twitter_consumer_key = 'YOUR_CONSUMER_KEY',
    twitter_consumer_secret = 'YOUR_CONSUMER_SECRET',
    twitter_access_token = 'YOUR_ACCESS_TOKEN',
    twitter_access_token_secret = 'YOUR_ACCESS_TOKEN_SECRET',
  },
})

To get your OAuth 1.0a credentials:
1. Go to https://developer.twitter.com/en/portal/dashboard
2. Create a new project/app (or use existing one)
3. Go to "Keys and Tokens" tab
4. Copy the following:
   - API Key (this is your Consumer Key)
   - API Key Secret (this is your Consumer Secret)
   - Access Token
   - Access Token Secret
5. Make sure your app has "Read and Write" permissions (Settings > App permissions)
      ]],
    }
  end

  local credentials = {
    consumer_key = consumer_key,
    consumer_secret = consumer_secret,
    access_token = access_token,
    access_token_secret = access_token_secret,
  }

  -- Build request body
  local request_body = {
    text = action.text,
  }

  -- Add media if provided
  if
    action.media_ids
    and type(action.media_ids) == 'table'
    and #action.media_ids > 0
  then
    request_body.media = {
      media_ids = action.media_ids,
    }
  end

  local url = 'https://api.twitter.com/2/tweets'
  local body_json = vim.json.encode(request_body)

  -- Build OAuth 1.0a Authorization header
  -- For JSON body, we need to include the text parameter in signature
  local body_params = {
    text = action.text,
  }

  local auth_header =
    build_oauth_header('POST', url, body_params, credentials)

  -- Build curl command for Twitter API v2
  local cmd = {
    'curl',
    '-s',
    '-X',
    'POST',
    url,
    '-H',
    'Content-Type: application/json',
    '-H',
    'Authorization: ' .. auth_header,
    '-d',
    body_json,
    '--max-time',
    '30',
  }

  -- Execute request
  local result
  local exit_code

  if vim.system then
    local job = vim.system(cmd, {
      text = true,
      timeout = 30000, -- 30 seconds
    })

    local system_result = job:wait()
    result = system_result.stdout or ''
    if system_result.stderr and system_result.stderr ~= '' then
      result = result .. '\n' .. system_result.stderr
    end
    exit_code = system_result.code
  else
    -- Fallback for older Neovim versions
    result = vim.fn.system(cmd)
    exit_code = vim.v.shell_error
  end

  -- Parse response
  local ok, response = pcall(vim.json.decode, result)

  if not ok then
    return {
      error = string.format(
        'Failed to parse Twitter API response.\n\nResponse: %s\n\nError: %s',
        result,
        response
      ),
    }
  end

  -- Check for errors
  if response.errors then
    local error_messages = {}
    for _, err in ipairs(response.errors) do
      table.insert(
        error_messages,
        string.format(
          '  - %s (code: %s)',
          err.message or 'Unknown error',
          err.code or 'unknown'
        )
      )
    end

    return {
      error = string.format(
        'Twitter API error:\n%s\n\nFull response: %s',
        table.concat(error_messages, '\n'),
        result
      ),
    }
  end

  -- Check for successful response
  if response.data and response.data.id and response.data.text then
    local tweet_url =
      string.format('https://twitter.com/user/status/%s', response.data.id)

    return {
      content = string.format(
        '✅ Tweet posted successfully!\n\n'
          .. 'Tweet ID: %s\n'
          .. 'Text: %s\n'
          .. 'URL: %s\n\n'
          .. 'Characters: %d/280',
        response.data.id,
        response.data.text,
        tweet_url,
        #response.data.text
      ),
    }
  else
    return {
      error = string.format(
        'Unexpected response from Twitter API.\n\nResponse: %s',
        result
      ),
    }
  end
end

function M.scheme()
  return {
    type = 'function',
    ['function'] = {
      name = 'post_tweet',
      description = [[
Post a tweet to Twitter/X using Twitter API v2 with OAuth 1.0a.

This tool allows you to post tweets directly from chat.nvim conversations.

PREREQUISITES:
1. Twitter Developer Account (https://developer.twitter.com/)
2. Create a project and app with "Read and Write" permissions
3. Generate OAuth 1.0a credentials in Keys and Tokens section
4. Configure in chat.nvim setup:

require('chat').setup({
  api_key = {
    twitter_consumer_key = 'YOUR_CONSUMER_KEY',
    twitter_consumer_secret = 'YOUR_CONSUMER_SECRET',
    twitter_access_token = 'YOUR_ACCESS_TOKEN',
    twitter_access_token_secret = 'YOUR_ACCESS_TOKEN_SECRET',
  },
})

EXAMPLES:

1. Basic tweet:
   @post_tweet text="Hello from chat.nvim! 🚀"

2. Tweet with emoji:
   @post_tweet text="Working on a cool project today! 💻✨"

3. Tweet with media (requires media upload first):
   @post_tweet text="Check out this screenshot!" media_ids=["1234567890"]

FEATURES:
- OAuth 1.0a User Context authentication
- Character limit validation (280 characters)
- Media attachment support
- Automatic URL generation for posted tweet
- Clear error messages for API issues

LIMITATIONS:
- Maximum 280 characters per tweet (for most languages)
- Media must be uploaded separately using Twitter's media/upload endpoint
- Requires Read and Write permissions

SECURITY:
- Credentials stored in Neovim config (keep it secure!)
- Never commit your credentials to version control
- Consider using environment variables for production

TROUBLESHOOTING:
- 401 Unauthorized: Check your OAuth credentials are correct
- 403 Forbidden: Ensure app has "Read and Write" permissions
- 429 Too Many Requests: Rate limit exceeded, wait before retrying
      ]],
      parameters = {
        type = 'object',
        properties = {
          text = {
            type = 'string',
            description = 'The tweet text content (max 280 characters)',
            maxLength = 280,
          },
          media_ids = {
            type = 'array',
            description = 'Optional media attachment IDs from Twitter media upload endpoint',
            items = { type = 'string' },
          },
        },
        required = { 'text' },
      },
    },
  }
end

function M.info(action, ctx)
  local ok, arguments = pcall(vim.json.decode, action)
  if ok then
    local preview = arguments.text
    if #preview > 50 then
      preview = preview:sub(1, 47) .. '...'
    end
    return string.format('post_tweet "%s"', preview)
  else
    return 'post_tweet'
  end
end

return M
