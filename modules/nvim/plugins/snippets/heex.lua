local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require 'luasnip.extras'
return {
  s({ trig = '<<', name = 'heex tag' }, { t '<% ', i(1), t ' %>' }),
  s({ trig = '<=', name = 'heex tag' }, { t '<%= ', i(1), t ' %>' }),
  s({ trig = '<.', name = 'heex component' }, { t '<.', i(1, 'tag'), t '>', i(2), t '</.', extras.rep(1), t '>' }),
}

