local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
	s({ trig = "ii", snippetType = "autosnippet" }, fmta("$ <> $", i(1))),
	s(
		{ trig = ";c", dscr = "code block", snippetType = "autosnippet" },
		fmta(
			[[
            #code(caption: [<>])[
            ```<>
            <>
            ```
            ]<>
        ]],
			{ i(1), i(2), i(3), i(4) }
		),
		{ condition = line_begin }
	),
	s(
		{ trig = ";t", dscr = "tip block", snippetType = "autosnippet" },
		fmta(
			[[
    #tip("Tip")[
        <>
    ]
]],
			i(1)
		),
		{ condition = line_begin }
	),
	s(
		{ trig = ";d", dscr = "definition block", snippetType = "autosnippet" },
		fmta(
			[[
    #tip("Definition")[
        <>
    ]
]],
			i(1)
		),
		{ condition = line_begin }
	),

	s({ trig = ";i", snippetType = "autosnippet" }, fmta("_<>_", i(1))),
	s({ trig = ";b", snippetType = "autosnippet" }, fmta("*<>*", i(1))),
	s({ trig = ";p", snippetType = "autosnippet" }, fmta('#image("<>")', i(1))),
}
