local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")

return {
	s(
		{ trig = "bqu", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{quantikz}
        & <>
      \end{quantikz}
      ]],
			{
				i(0),
			}
		),
		{ condition = tex.in_text }
	),
	s(
		{ trig = "cl", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\ctrl{"), i(1), t("}") }), sn(nil, { t("\\ctrl["), i(1), t("]{"), i(2), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "ocl", snippetType = "autosnippet", priority = 2000 },
		c(1, { sn(nil, { t("\\octrl{"), i(1), t("}") }), sn(nil, { t("\\octrl["), i(1), t("]{"), i(2), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "tar", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\targ{"), i(1), t("}") }), sn(nil, { t("\\targX{"), i(1), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "gate", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\gate{"), i(1), t("}") }), sn(nil, { t("\\gate["), i(1), t("]{"), i(2), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "g(%a)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta("\\gate{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "wire", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\wire["), i(1), t("]{"), i(2), t("}") }), sn(nil, { t("\\wire{"), i(1), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "mt", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\meter{"), i(1), t("}") }), sn(nil, { t("\\meter["), i(1), t("]{"), i(2), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "phase", snippetType = "autosnippet" },
		fmta("\\phase{<>}", {
			i(0),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "swap", snippetType = "autosnippet" },
		fmta("\\swap{<>}", {
			i(0),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "ls", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\lstick{"), i(1), t("}") }), sn(nil, { t("\\lstick["), i(1), t("]{"), i(2), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "rs", snippetType = "autosnippet" },
		c(1, { sn(nil, { t("\\rstick{"), i(1), t("}") }), sn(nil, { t("\\rstick["), i(1), t("]{"), i(2), t("}") }) }),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "group", snippetType = "autosnippet" },
		fmta("\\gategroup[<>,steps=<>]{<>}", {
			i(1),
			i(2),
			i(0),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "slice", snippetType = "autosnippet" },
		fmta("\\slice{<>}", {
			i(0),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "push", snippetType = "autosnippet" },
		fmta("\\push{<>}", {
			i(0),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "ms", snippetType = "autosnippet" },
		c(1, {
			sn(nil, { t("\\measure{"), i(1), t("}") }),
			sn(nil, { t("\\measuretab{"), i(1), t("}") }),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "ket", snippetType = "autosnippet" },
		fmta("\\ket{<>}", {
			i(0),
		}),
		{ condition = tex.in_quantikz }
	),
	s(
		{ trig = "bra", snippetType = "autosnippet" },
		fmta("\\bra{<>}", {
			i(0),
		}),
		{ condition = tex.in_quantikz }
	),
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("\\alpha"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("\\beta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("\\gamma"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";G", snippetType = "autosnippet" }, {
		t("\\Gamma"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";d", snippetType = "autosnippet" }, {
		t("\\delta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";D", snippetType = "autosnippet" }, {
		t("\\Delta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";e", snippetType = "autosnippet" }, {
		t("\\epsilon"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";ve", snippetType = "autosnippet" }, {
		t("\\varepsilon"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";z", snippetType = "autosnippet" }, {
		t("\\zeta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";h", snippetType = "autosnippet" }, {
		t("\\eta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";o", snippetType = "autosnippet" }, {
		t("\\theta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";vo", snippetType = "autosnippet" }, {
		t("\\vartheta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";O", snippetType = "autosnippet" }, {
		t("\\Theta"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";k", snippetType = "autosnippet" }, {
		t("\\kappa"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";l", snippetType = "autosnippet" }, {
		t("\\lambda"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";L", snippetType = "autosnippet" }, {
		t("\\Lambda"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";m", snippetType = "autosnippet" }, {
		t("\\mu"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";n", snippetType = "autosnippet" }, {
		t("\\nu"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";x", snippetType = "autosnippet" }, {
		t("\\xi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";X", snippetType = "autosnippet" }, {
		t("\\Xi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";i", snippetType = "autosnippet" }, {
		t("\\pi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";I", snippetType = "autosnippet" }, {
		t("\\Pi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";r", snippetType = "autosnippet" }, {
		t("\\rho"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";s", snippetType = "autosnippet" }, {
		t("\\sigma"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";S", snippetType = "autosnippet" }, {
		t("\\Sigma"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";t", snippetType = "autosnippet" }, {
		t("\\tau"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";f", snippetType = "autosnippet" }, {
		t("\\phi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";vf", snippetType = "autosnippet" }, {
		t("\\varphi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";F", snippetType = "autosnippet" }, {
		t("\\Phi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";c", snippetType = "autosnippet" }, {
		t("\\chi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";p", snippetType = "autosnippet" }, {
		t("\\psi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";P", snippetType = "autosnippet" }, {
		t("\\Psi"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";w", snippetType = "autosnippet" }, {
		t("\\omega"),
	}, { condition = tex.in_quantikz }),
	s({ trig = ";W", snippetType = "autosnippet" }, {
		t("\\Omega"),
	}, { condition = tex.in_quantikz }),
}
