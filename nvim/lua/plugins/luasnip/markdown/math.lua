local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")

return {
	s({ trig = "ii", snippetType = "autosnippet" }, fmta("$<>$", i(1))),
	s({ trig = "dd", snippetType = "autosnippet" }, fmta("$$\n<>\n$$", i(1))),
}
