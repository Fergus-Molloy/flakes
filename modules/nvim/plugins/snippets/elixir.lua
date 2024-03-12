local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s({ trig = '@@', name = 'pipe', describe = 'pipe', snippetType = 'autosnippet' }, { t '|> ', i(1) }),

  s({ trig = 'ok', name = 'match ok' }, { t '{ :ok, ', i(1, 'val'), t ' } -> ', i(2) }),
  s({ trig = 'error', name = 'match error' }, { t '{ :error, ', i(1, 'val'), t ' } -> ', i(2) }),
}
