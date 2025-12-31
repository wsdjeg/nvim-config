vim.api.nvim_create_user_command('RulesetsList', function(opt)
  local nt = require('notify')
  local rulesets_api = require('github.rulesets')
  local rulesets =
    rulesets_api.get_repository_rules(opt.fargs[1], opt.fargs[2])

  for _, r in ipairs(rulesets) do
    local rule =
      rulesets_api.get_repository_ruleset(opt.fargs[1], opt.fargs[2], r.id)
    nt.notify(
      string.format('%s(%s) %s', rule.name, rule.enforcement, rule.target)
    )
    nt.notify('include_refs:')
    for _, condition in pairs(rule.conditions) do
      for _, ref in ipairs(condition.include) do
        nt.notify(ref)
      end
    end
    nt.notify('rules:')
    for _, t in ipairs(rule.rules) do
      nt.notify(t.type)
    end
  end
end, { nargs = '*' })
