local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")

-- Return snippet tables
return {
    -- SUPERSCRIPT
    s(
        { trig = "([%w%)%]%}])'", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SUBSCRIPT
    s(
        { trig = "([%w%)%]%}]);", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SUBSCRIPT AND SUPERSCRIPT
    s(
        { trig = "([%w%)%]%}])__", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>^{<>}_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- TEXT SUBSCRIPT
    s(
        { trig = "sd", snippetType = "autosnippet", wordTrig = false },
        fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
        { condition = tex.in_mathzone }
    ),
    -- SUPERSCRIPT SHORTCUT
    -- Places the first alphanumeric character after the trigger into a superscript.
    s(
        { trig = '([%w%)%]%}])"([%w])', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            f(function(_, snip)
                return snip.captures[2]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SUBSCRIPT SHORTCUT
    -- Places the first alphanumeric character after the trigger into a subscript.
    s(
        { trig = "([%w%)%]%}]):([%w])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            f(function(_, snip)
                return snip.captures[2]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
    s(
        { trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>e^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- ZERO SUBSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("0"),
        }),
        { condition = tex.in_mathzone }
    ),
    -- MINUS ONE SUPERSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])11", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("-1"),
        }),
        { condition = tex.in_mathzone }
    ),
    -- J SUBSCRIPT SHORTCUT (since jk triggers snippet jump forward)
    s(
        { trig = "([%a%)%]%}])JJ", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("j"),
        }),
        { condition = tex.in_mathzone }
    ),
    -- PLUS SUPERSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])%+%+", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("+"),
        }),
        { condition = tex.in_mathzone }
    ),
    -- COMPLEMENT SUPERSCRIPT
    s(
        { trig = "([%a%)%]%}])CC", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("\\complement"),
        }),
        { condition = tex.in_mathzone }
    ),
    -- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
    s(
        { trig = "([%a%)%]%}])%*%*", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            t("*"),
        }),
        { condition = tex.in_mathzone }
    ),
    -- VECTOR, i.e. \vec
    s(
        { trig = "([^%a])vv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\vec{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- DEFAULT UNIT VECTOR WITH SUBSCRIPT, i.e. \unitvector_{}
    s(
        { trig = "([^%a])ue", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\unitvector_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- UNIT VECTOR WITH HAT, i.e. \uvec{}
    s(
        { trig = "([^%a])uv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\uvec{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- MATRIX, i.e. \vec
    s(
        { trig = "([^%a])mt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\mat{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- FRACTION
    s(
        { trig = "([^%a])ff", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\frac{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- ANGLE
    s(
        { trig = "([^%a])gg", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\ang{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- ABSOLUTE VALUE
    s(
        { trig = "([^%a])aa", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\abs{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SQUARE ROOT
    s(
        { trig = "([^%\\])sq", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\sqrt{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- BINOMIAL SYMBOL
    s(
        { trig = "([^%\\])bnn", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\binom{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- LOGARITHM WITH BASE SUBSCRIPT
    s(
        { trig = "([^%a%\\])ll", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\log_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex.in_mathzone }
    ),
    -- DERIVATIVE with denominator only
    s(
        { trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\dvOne{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- DERIVATIVE with numerator and denominator
    s(
        { trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\dv{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- DERIVATIVE with numerator, denominator, and higher-order argument
    s(
        { trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\dvN{<>}{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
            i(3),
        }),
        { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with denominator only
    s(
        { trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\pdvOne{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with numerator and denominator
    s(
        { trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\pdv{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
    s(
        { trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\pdvN{<>}{<>}{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
            i(3),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SUM with lower limit
    s(
        { trig = "([^%a])sM", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\sum_{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
        }),
        { condition = tex.in_mathzone }
    ),
    -- SUM with upper and lower limit
    s(
        { trig = "([^%a])smm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\sum_{<>}^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- INTEGRAL with upper and lower limit
    s(
        { trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\int_{<>}^{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            i(1),
            i(2),
        }),
        { condition = tex.in_mathzone }
    ),
    -- INTEGRAL from positive to negative infinity
    s(
        { trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\int_{\\infty}^{\\infty}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    -- BOXED command
    s(
        { trig = "([^%a])bb", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("<>\\boxed{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    --
    -- BEGIN STATIC SNIPPETS
    --

    -- DIFFERENTIAL, i.e. \diff
    s({ trig = "df", snippetType = "autosnippet", priority = 2000, snippetType = "autosnippet" }, {
        t("\\diff"),
    }, { condition = tex.in_mathzone }),
    -- BASIC INTEGRAL SYMBOL, i.e. \int
    s({ trig = "in1", snippetType = "autosnippet" }, {
        t("\\int"),
    }, { condition = tex.in_mathzone }),
    -- DOUBLE INTEGRAL, i.e. \iint
    s({ trig = "in2", snippetType = "autosnippet" }, {
        t("\\iint"),
    }, { condition = tex.in_mathzone }),
    -- TRIPLE INTEGRAL, i.e. \iiint
    s({ trig = "in3", snippetType = "autosnippet" }, {
        t("\\iiint"),
    }, { condition = tex.in_mathzone }),
    -- CLOSED SINGLE INTEGRAL, i.e. \oint
    s({ trig = "oi1", snippetType = "autosnippet" }, {
        t("\\oint"),
    }, { condition = tex.in_mathzone }),
    -- CLOSED DOUBLE INTEGRAL, i.e. \oiint
    s({ trig = "oi2", snippetType = "autosnippet" }, {
        t("\\oiint"),
    }, { condition = tex.in_mathzone }),
    -- GRADIENT OPERATOR, i.e. \grad
    s({ trig = "gdd", snippetType = "autosnippet" }, {
        t("\\grad "),
    }, { condition = tex.in_mathzone }),
    -- CURL OPERATOR, i.e. \curl
    s({ trig = "cll", snippetType = "autosnippet" }, {
        t("\\curl "),
    }, { condition = tex.in_mathzone }),
    -- DIVERGENCE OPERATOR, i.e. \divergence
    s({ trig = "DI", snippetType = "autosnippet" }, {
        t("\\div "),
    }, { condition = tex.in_mathzone }),
    -- LAPLACIAN OPERATOR, i.e. \laplacian
    s({ trig = "laa", snippetType = "autosnippet" }, {
        t("\\laplacian "),
    }, { condition = tex.in_mathzone }),
    -- PARALLEL SYMBOL, i.e. \parallel
    s({ trig = "||", snippetType = "autosnippet" }, {
        t("\\parallel"),
    }, { condition = tex.in_mathzone }),
    -- CDOTS, i.e. \cdots
    s({ trig = "cdd", snippetType = "autosnippet" }, {
        t("\\cdots"),
    }, { condition = tex.in_mathzone }),
    -- LDOTS, i.e. \ldots
    s({ trig = "ldd", snippetType = "autosnippet" }, {
        t("\\ldots"),
    }, { condition = tex.in_mathzone }),
    -- EQUIV, i.e. \equiv
    s({ trig = "eqq", snippetType = "autosnippet" }, {
        t("\\equiv "),
    }, { condition = tex.in_mathzone }),
    -- SETMINUS, i.e. \setminus
    s({ trig = "stm", snippetType = "autosnippet" }, {
        t("\\setminus "),
    }, { condition = tex.in_mathzone }),
    -- SUBSET, i.e. \subset
    s({ trig = "sbb", snippetType = "autosnippet" }, {
        t("\\subset "),
    }, { condition = tex.in_mathzone }),
    -- APPROX, i.e. \approx
    s({ trig = "px", snippetType = "autosnippet" }, {
        t("\\approx "),
    }, { condition = tex.in_mathzone }),
    -- PROPTO, i.e. \propto
    s({ trig = "pt", snippetType = "autosnippet" }, {
        t("\\propto "),
    }, { condition = tex.in_mathzone }),
    -- COLON, i.e. \colon
    s({ trig = "::", snippetType = "autosnippet" }, {
        t("\\colon "),
    }, { condition = tex.in_mathzone }),
    -- IMPLIES, i.e. \implies
    s({ trig = ">>", snippetType = "autosnippet" }, {
        t("\\implies "),
    }, { condition = tex.in_mathzone }),
    -- DOT PRODUCT, i.e. \cdot
    s({ trig = "c.", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\cdot"),
    }, { condition = tex.in_mathzone }),
    -- CROSS PRODUCT, i.e. \times
    s({ trig = "xx", snippetType = "autosnippet" }, {
        t("\\times "),
    }, { condition = tex.in_mathzone }),

    --------------------------
    -- Below are firond'd snippets
    s({ trig = "sin", snippetType = "autosnippet" }, {
        t("\\sin"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "asin", snippetType = "autosnippet" }, {
        t("\\arcsin"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "cos", snippetType = "autosnippet" }, {
        t("\\cos"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "acos", snippetType = "autosnippet" }, {
        t("\\arccos"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "tan", snippetType = "autosnippet" }, {
        t("\\tan"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "atan", snippetType = "autosnippet" }, {
        t("\\arctan"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "cot", snippetType = "autosnippet" }, {
        t("\\cot"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "acot", snippetType = "autosnippet" }, {
        t("\\arccot"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "csc", snippetType = "autosnippet" }, {
        t("\\csc"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "acsc", snippetType = "autosnippet" }, {
        t("\\arccsc"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "sec", snippetType = "autosnippet" }, {
        t("\\sec"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "asec", snippetType = "autosnippet" }, {
        t("\\arcsec"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "log", snippetType = "autosnippet" }, {
        t("\\log"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "ln", snippetType = "autosnippet" }, {
        t("\\ln"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "exp", snippetType = "autosnippet" }, {
        t("\\exp"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "grad", snippetType = "autosnippet" }, {
        t("\\grad"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "curl", snippetType = "autosnippet" }, {
        t("\\curl"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "div", snippetType = "autosnippet" }, {
        t("\\div"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "lap", snippetType = "autosnippet" }, {
        t("\\laplacian"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bbr", snippetType = "autosnippet" }, {
        t("\\mathbb{R}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bbq", snippetType = "autosnippet" }, {
        t("\\mathbb{Q}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bbh", snippetType = "autosnippet" }, {
        t("\\mathbb{H}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bbc", snippetType = "autosnippet" }, {
        t("\\mathbb{C}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bbz", snippetType = "autosnippet" }, {
        t("\\mathbb{Z}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bbn", snippetType = "autosnippet" }, {
        t("\\mathbb{N}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bb1", snippetType = "autosnippet", priority = 2000 }, {
        t("\\mathbbm{1}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "bbe", snippetType = "autosnippet" }, {
        t("\\mathbb{E}"),
    }, { condition = tex.in_mathzone }),
    s(
        { trig = "bb(%w)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("\\mathbb{<>}", {
            f(function(_, snip)
                return string.upper(snip.captures[1])
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    s({ trig = "exp", snippetType = "autosnippet" }, {
        t("\\exp"),
    }, { condition = tex.in_mathzone }),
    s(
        { trig = "bar", snippetType = "autosnippet", priority = 2000 },
        fmta("\\overline{<>}", {
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "bar", snippetType = "autosnippet" },
        fmta("\\overline{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\%a+)bar", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("\\overline{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(%a)bar", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("\\overline{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "td", snippetType = "autosnippet", priority = 2000 },
        fmta("\\tilde{<>}", {
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "td", snippetType = "autosnippet" },
        fmta("\\ttlde{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(\\%a+)~", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("\\tilde{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "(%a)~", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
        fmta("\\tilde{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "dot", snippetType = "autosnippet", priority = 2000 },
        fmta("\\dot{<>}", {
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "dot", snippetType = "autosnippet" },
        fmta("\\dot{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "doo", snippetType = "autosnippet", priority = 2000 },
        fmta("\\ddot{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "vb", snippetType = "autosnippet" },
        c(1, { sn(nil, { t("\\vb{"), i(1), t("}") }), sn(nil, { t("\\vb*{"), i(1), t("}") }) }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "vu", snippetType = "autosnippet" },
        c(1, { sn(nil, { t("\\vu{"), i(1), t("}") }), sn(nil, { t("\\vu*{"), i(1), t("}") }) }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "hat", snippetType = "autosnippet", priority = 2000 },
        fmta("\\hat{<>}", {
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "hat", snippetType = "autosnippet" },
        fmta("\\hat{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "vec", snippetType = "autosnippet", priority = 2000 },
        fmta("\\vec{<>}", {
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "vec", snippetType = "autosnippet" },
        fmta("\\vec{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    -- s({ trig = "rr", snippetType = "autosnippet" }, fmta("\\ran", {}), { condition = tex.in_mathzone }),
    s({ trig = "kk", snippetType = "autosnippet" }, fmta("\\ker", {}), { condition = tex.in_mathzone }),
    s({ trig = "aut", snippetType = "autosnippet" }, fmta("\\Aut", {}), { condition = tex.in_mathzone }),
    s({ trig = "gal", snippetType = "autosnippet" }, fmta("\\Gal", {}), { condition = tex.in_mathzone }),
    s({ trig = "rank", snippetType = "autosnippet" }, fmta("\\rank", {}), { condition = tex.in_mathzone }),
    s({ trig = "dim", snippetType = "autosnippet" }, fmta("\\dim", {}), { condition = tex.in_mathzone }),
    s({ trig = "det", snippetType = "autosnippet" }, fmta("\\det", {}), { condition = tex.in_mathzone }),
    s({ trig = "vol", snippetType = "autosnippet" }, fmta("\\Vol", {}), { condition = tex.in_mathzone }),
    s(
        { trig = "gt", snippetType = "autosnippet" },
        fmta("\\gt{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "sup", snippetType = "autosnippet" },
        fmta("\\sup\\limits_{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "inf", snippetType = "autosnippet" },
        fmta("\\inf\\limits_{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s({ trig = "dd", snippetType = "autosnippet" }, fmta("\\d ", {}), { condition = tex.in_mathzone }),
    s({ trig = "poly", snippetType = "autosnippet" }, fmta("\\poly", {}), { condition = tex.in_mathzone }),
    s(
        { trig = "mod", wordTrig = false, snippetType = "autosnippet" },
        fmta("\\mod{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "nmod", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
        fmta("\\nmod{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "pmod", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
        fmta("\\pmod{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "sgn", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
        fmta("\\sgn", {}),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "gcd", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
        fmta("\\gcd", {}),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "deg", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
        fmta("\\degree", {}),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "pr", wordTrig = false, snippetType = "autosnippet" },
        fmta("\\Pr", {}),
        { condition = tex.in_mathzone }
    ),
    s({ trig = "...", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\dots"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "v.", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\vdot"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "\\vdot.", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\vdots"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "iff", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\iff"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "inn", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\in"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "notin", wordTrig = false, snippetType = "autosnippet" }, {
        t("not\\in"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "aa", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\forall"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "ee", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\exists"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "!=", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\neq"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "==", wordTrig = false, snippetType = "autosnippet" }, {
        t("&="),
    }, { condition = tex.in_mathzone }),
    s({ trig = "~=", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\approx"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "~~", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\sim"),
    }, { condition = tex.in_mathzone }),
    s({ trig = ">=", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\geq"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "<=", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\leq"),
    }, { condition = tex.in_mathzone }),
    s({ trig = ">>", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\gg"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "<<", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\ll"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "cp", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\cp"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "get", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\get"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "to", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\to"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "mto", wordTrig = false, snippetType = "autosnippet", priority = 1001 }, {
        t("\\mapsto"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "\\\\\\", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\setminus"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "||", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\mid"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "mid", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\mid"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "nmid", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
        t("\\nmid"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "sr", wordTrig = false, snippetType = "autosnippet" }, {
        t("^2"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "cb", wordTrig = false, snippetType = "autosnippet" }, {
        t("^3"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "inv", wordTrig = false, snippetType = "autosnippet" }, {
        t("^{-1}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "**", wordTrig = false, snippetType = "autosnippet" }, {
        t("^*"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "  ", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\,"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "<>", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\diamond"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "+-", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\pm"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "-+", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\mp"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "rhs", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\mathrm{R.H.S}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "lhs", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\mathrm{L.H.S}"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "cap", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\cap"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "cup", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\cup"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "sub", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\subseteq"),
    }, { condition = tex.in_mathzone }),
    -- s({ trig = "sup", wordTrig = false, snippetType = "autosnippet" }, {
    --   t("\\supseteq"),
    -- }, { condition = tex.in_mathzone }),
    s({ trig = "oo", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\infty"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "tp", wordTrig = false, snippetType = "autosnippet" }, {
        t("^\\top"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "dr", wordTrig = false, snippetType = "autosnippet" }, {
        t("^\\dagger"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "perp", wordTrig = false, snippetType = "autosnippet" }, {
        t("^\\perp"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "ss", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\star"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "xx", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\times"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "=>", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\implies"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "llr", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\longleftrightarrow"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "cir", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\circ"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "iso", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\cong"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "ihbar", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
        t("i\\hbar"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "hbar", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\hbar"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "ns", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\unlhd"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "eqv", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\equiv"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "##", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\#"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "ell", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
        t("\\ell"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "ot", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\otimes"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "op", wordTrig = false, snippetType = "autosnippet" }, {
        t("\\oplus"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "not", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
        t("\\not"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "par", wordTrig = false, snippetType = "autosnippet", priority = 2000 }, {
        t("\\partial"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "land", snippetType = "autosnippet" }, {
        t("\\land"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "lor", snippetType = "autosnippet" }, {
        t("\\lor"),
    }, { condition = tex.in_mathzone }),
    s(
        { trig = "->", snippetType = "autosnippet" },
        fmta("\\xlongrightarrow{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "<-", snippetType = "autosnippet" },
        fmta("\\xlongleftarrow{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s({ trig = "min", snippetType = "autosnippet" }, fmta("\\min", {}), { condition = tex.in_mathzone }),
    s(
        { trig = "\\minl", snippetType = "autosnippet" },
        fmta("\\min\\limits_{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s({ trig = "max", snippetType = "autosnippet" }, fmta("\\max", {}), { condition = tex.in_mathzone }),
    s(
        { trig = "\\maxl", snippetType = "autosnippet" },
        fmta("\\max\\limits_{<>}", { i(0) }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "amin", snippetType = "autosnippet" },
        fmta("\\argmin\\limits_{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "amax", snippetType = "autosnippet" },
        fmta("\\argmax\\limits_{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
}
