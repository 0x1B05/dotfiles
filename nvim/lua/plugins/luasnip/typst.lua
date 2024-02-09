local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
	s({ trig = "ii", snippetType = "autosnippet" }, fmta("$<>$", i(1))),
	s(
		{ trig = ";c", dscr = "code block", snippetType = "autosnippet" },
		fmta(
			[[
            #code()[
            ```<>
            <>
            ```
            ]<>
        ]],
			{ i(1), i(2), i(3) }
		),
		{ condition = line_begin }
	),
	s({ trig = ";i", snippetType = "autosnippet" }, fmta("_<>_", i(1))),
	s({ trig = ";b", snippetType = "autosnippet" }, fmta("*<>*", i(1))),
	s({ trig = ";p", snippetType = "autosnippet" }, fmta("#image(<>)", i(1))),
	s(
		{ trig = ";t", snippetType = "autosnippet" },
		fmta(
			[[
    #tip("提示")[
        <>
    ]
]],
			i(1)
		)
	),
}
