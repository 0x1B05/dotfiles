local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")

return {
    s({ trig = "dps", snippetType = "autosnippet" }, {
        t("\\displaystyle"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "if", snippetType = "autosnippet" }, {
        t("\\text{\\ if\\ }"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "or", snippetType = "autosnippet" }, { t("\\text{\\ or\\ }") }, { condition = tex.in_mathzone }),
    s({ trig = "otherwise", snippetType = "autosnippet" }, {
        t("\\text{\\ otherwise\\ }"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "then", snippetType = "autosnippet" }, {
        t("\\text{\\ then\\ }"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "since", snippetType = "autosnippet" }, {
        t("\\text{\\ since\\ }"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "by", snippetType = "autosnippet" }, {
        t("\\text{\\ by\\ }"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "which", snippetType = "autosnippet" }, {
        t("\\text{ for which } "),
    }, { condition = tex.in_mathzone }),
    s({ trig = "all", snippetType = "autosnippet" }, {
        t("\\text{ for all } "),
    }, { condition = tex.in_mathzone }),
    s({ trig = "and", snippetType = "autosnippet" }, {
        t("\\quad \\text{and} \\quad"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "forall", snippetType = "autosnippet" }, {
        t("\\text{ for all } "),
    }, { condition = tex.in_mathzone }),
    s({ trig = "label", snippetType = "autosnippet" }, {
        t("\\label{"),
        i(0),
        t("}"),
    }, { condition = tex.in_text, show_condition = tex.in_text }),
    s({ trig = "wlog", snippetType = "autosnippet" }, {
        t("without loss of generality"),
    }, { condition = tex.in_text }),
    s({ trig = "Wlog", snippetType = "autosnippet" }, {
        t("Without loss of generality"),
    }, { condition = tex.in_text }),
    s({ trig = "%%", snippetType = "autosnippet" }, {
        t("\\%"),
    }, { condition = tex.in_text }),
    s({ trig = "&&", snippetType = "autosnippet" }, {
        t("\\&"),
    }, { condition = tex.in_text }),
    s({ trig = "##", snippetType = "autosnippet" }, {
        t("\\#"),
    }, { condition = tex.in_text }),
    s({ trig = "thm", snippetType = "autosnippet" }, {
        t("theorem"),
    }, { condition = tex.in_text }),
    s({ trig = "propp", snippetType = "autosnippet" }, {
        t("proposition"),
    }, { condition = tex.in_text }),
    s({ trig = "deff", snippetType = "autosnippet" }, {
        t("definition"),
    }, { condition = tex.in_text }),
    s({ trig = "exaa", snippetType = "autosnippet" }, {
        t("example"),
    }, { condition = tex.in_text }),
    s({ trig = "iee", snippetType = "autosnippet" }, {
        t("i.e."),
    }, { condition = tex.in_text }),
    s({ trig = "stt", snippetType = "autosnippet" }, {
        t("such that"),
    }, { condition = tex.in_text }),
    s({ trig = "iff", snippetType = "autosnippet" }, {
        t("if and only if"),
    }, { condition = tex.in_text }),
    s({ trig = "=>", snippetType = "autosnippet" }, {
        t("\\(\\implies\\)"),
    }, { condition = tex.in_text }),
}
