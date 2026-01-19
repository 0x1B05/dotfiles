local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")

return {
	s(
		{ trig = "bmat", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{bmatrix}
        <>
      \end{bmatrix}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Bmat", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{Bmatrix}
        <>
      \end{Bmatrix}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "pmat", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{pmatrix}
        <>
      \end{pmatrix}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Vmat", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{Vmatrix}
        <>
      \end{Vmatrix}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "pmat", snippetType = "autosnippet" },
		fmta(
			[[
      \pmat{<>}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Bmat", snippetType = "autosnippet" },
		fmta(
			[[
      \Bmat{<>}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "vmat", snippetType = "autosnippet" },
		fmta(
			[[
      \vmat{<>}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "Vmat", snippetType = "autosnippet" },
		fmta(
			[[
      \Vmat{<>}
      ]],
			{ i(0) }
		),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "pma(%a)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\pmat<>{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(0),
		}),
		{ condition = tex.in_mathzone }
	),
}
