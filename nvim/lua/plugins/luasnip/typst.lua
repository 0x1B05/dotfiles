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
            #figure(
              ```<>
              <>
              ```,
              caption: [<>]
            )<>
        ]],
			{ i(1), i(2), i(3), i(4) }
		),
		{ condition = line_begin }
	),
	s(
		{ trig = ";t", dscr = "tip block", snippetType = "autosnippet" },
		fmta(
			[[
    #tip-box(title: "<>")[
        <>
    ]
]],
			{ i(1), i(2) }
		),
		{ condition = line_begin }
	),
	s(
		{ trig = ";d", dscr = "definition block", snippetType = "autosnippet" },
		fmta(
			[[
    #definition(title: "<>")[
        <>
    ]
]],
			{ i(1), i(2) }
		),
		{ condition = line_begin }
	),
	s(
		{ trig = ";e", dscr = "example block", snippetType = "autosnippet" },
		fmta(
			[[
    #example(title: "<>")[
        <>
    ]
]],
			{ i(1), i(2) }
		),
		{ condition = line_begin }
	),

	s(
		{ trig = "#ud", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("#underline[<>]", { i(1) })
	),
	s({ trig = "#strk", regTrig = true, wordTrig = false, snippetType = "autosnippet" }, fmta("#strike[<>]", { i(1) })),

	s({ trig = ";i", snippetType = "autosnippet" }, fmta("_<>_", i(1))),
	s({ trig = ";b", snippetType = "autosnippet" }, fmta("*<>*", i(1))),
	s({ trig = ";p", snippetType = "autosnippet" }, fmta('#image("<>")', i(1))),
}
