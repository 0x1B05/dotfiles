local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
	s(
		"localreq",
		fmt('local {} = require("{}")', {
			l(l._1:match("[^.]*$"):gsub("[^%a]+", "_"), 1),
			i(1, "module"),
		})
	),
	s(
		{ trig = "add", snippetType = "autosnippet" },
		fmta('["<>"] = "<>",', {
			i(1),
			i(2),
		})
	),
	ls.parser.parse_snippet("lm", "local M = {}\n\n$1 \n\nreturn M"),
	s(
		{ trig = "optsnip", snippetType = "autosnippet" },
		fmta(
			[[
      s(
        { trig = "<>", snippetType = "autosnippet" },
        c(1, { sn(nil, { t("\\<>{"), i(1), t("}") }), sn(nil, { t("\\<>["), i(1), t("]{"), i(2), t("}") }) }),
        { condition = tex.<> }
      ),
      ]],
			{ i(1), rep(1), rep(1), c(2, { t("in_quantikz"), t("in_mathzone") }) }
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "starsnip", snippetType = "autosnippet" },
		fmta(
			[[
      s(
        { trig = "<>", snippetType = "autosnippet" },
        c(1, { sn(nil, { t("\\<>{"), i(1), t("}") }), sn(nil, { t("\\<>*{"), i(1), t("}") }) }),
        { condition = tex.<> }
      ),
      ]],
			{ i(1), rep(1), rep(1), c(2, { t("in_quantikz"), t("in_mathzone") }) }
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "fmtasnip", snippetType = "autosnippet" },
		fmta(
			[[
      s({ trig = "<>", snippetType = "autosnippet" },
        fmta("\\<>{<<>>}", {
        <>
        }),
       { condition = tex.<> }),
      ]],
			{ i(1), rep(1), i(2, "i(0),"), c(3, { t("in_mathzone"), t("in_quantikz") }) }
		),
		{ condition = line_begin }
	),
	s(
		{ trig = "tsnip", snippetType = "autosnippet" },
		fmta(
			[[
      s({ trig = "<>", snippetType = "autosnippet" }, {
        t("\\<>"),
      }, { condition = tex.<> }),
      ]],
			{ i(1), rep(1), c(2, { t("in_mathzone"), t("in_quantikz") }) }
		),
		{ condition = line_begin }
	),
	-- PRINT
	s(
		{ trig = "pp", snippetType = "autosnippet" },
		fmta(
			[[
        print(<>)
        ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	-- DO RETURN END
	s(
		{ trig = "XX", snippetType = "autosnippet" },
		fmta(
			[[
        do return end
        ]],
			{}
		),
		{ condition = line_begin }
	),
}
