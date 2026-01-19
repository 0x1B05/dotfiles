local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
	s(
		"link",
		fmta("[<>](<>)", { i(1), f(function(_, snip)
			return snip.env.TM_SELECTED_TEXT[1] or {}
		end, {}) })
	),
	s({ trig = ";b", snippetType = "autosnippet" }, fmta("**<>**", i(1))),
	s({ trig = ";t", snippetType = "autosnippet" }, fmta("*<>*", i(1))),
	-- s({ trig = "xx", snippetType = "autosnippet" }, fmta("$\\times$", {})),
	s(
		{ trig = ";c", snippetType = "autosnippet" },
		fmta(
			[[
      ```<>
      <>
      ```
      ]],
			{ i(1), i(0) }
		)
	),
}
