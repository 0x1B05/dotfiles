local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")

-- Return snippet tables
return {
    -- GENERIC ENVIRONMENT
    s(
        { trig = "new", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{<>}
            <>
        \end{<>}
      ]],
            {
                i(1),
                d(2, get_visual),
                rep(1),
            }
        ),
        { condition = line_begin }
    ),
    -- ENVIRONMENT WITH ONE EXTRA ARGUMENT
    s(
        { trig = "n2", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{<>}{<>}
            <>
        \end{<>}
      ]],
            {
                i(1),
                i(2),
                d(3, get_visual),
                rep(1),
            }
        ),
        { condition = line_begin }
    ),
    -- ENVIRONMENT WITH TWO EXTRA ARGUMENTS
    s(
        { trig = "n3", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{<>}{<>}{<>}
            <>
        \end{<>}
      ]],
            {
                i(1),
                i(2),
                i(3),
                d(4, get_visual),
                rep(1),
            }
        ),
        { condition = line_begin }
    ),
    -- TOPIC ENVIRONMENT (my custom tcbtheorem environment)
    s(
        { trig = "nt", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{topic}{<>}{<>}
            <>
        \end{topic}
      ]],
            {
                i(1),
                i(2),
                d(3, get_visual),
            }
        ),
        { condition = line_begin }
    ),
    -- EQUATION
    s(
        { trig = "nn", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{equation*}
            <>
        \end{equation*}
      ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
    -- Equation, choice for labels
    s(
        {
            trig = "beq",
            dscr = "Expands 'beq' into an equation environment, with a choice for labels",
            snippetType = "autosnippet",
        },
        fmta(
            [[
        \begin{equation}<>
          <>
        \end{equation}
      ]],
            {
                c(1, {
                    sn(
                        2, -- Choose to specify an equation label
                        {
                            t("\\label{eq:"),
                            i(1),
                            t("}"),
                        }
                    ),
                    t([[]]), -- Choose no label
                }, {}),
                i(2),
            }
        )
    ),
    -- SPLIT EQUATION
    s(
        { trig = "ss", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{equation*}
            \begin{split}
                <>
            \end{split}
        \end{equation*}
      ]],
            {
                d(1, get_visual),
            }
        ),
        { condition = line_begin }
    ),
    -- ALIGN
    s(
        { trig = "all", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{align*}
            <>
        \end{align*}
      ]],
            {
                i(1),
            }
        ),
        { condition = line_begin }
    ),
    s(
        { trig = "bal", snippetType = "autosnippet" },
        fmta(
            [[
      \begin{aligned}
        <>
      \end{aligned}
      ]],
            {
                i(0),
            }
        ),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "bal", snippetType = "autosnippet", priority = 2000 },
        fmta(
            [[
      \begin{aligned}
        <>
      \end{aligned}
      ]],
            {
                d(1, get_visual),
            }
        ),
        { condition = tex.in_mathzone }
    ),
    -- ITEMIZE
    s(
        { trig = "itt", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{itemize}

            \item <>

        \end{itemize}
      ]],
            {
                i(0),
            }
        ),
        { condition = line_begin }
    ),
    -- ENUMERATE
    s(
        { trig = "enn", snippetType = "autosnippet" },
        fmta(
            [[
        \begin{enumerate}

            \item <>

        \end{enumerate}
      ]],
            {
                i(0),
            }
        )
    ),
    -- INLINE MATH
    s(
        { trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>$<>$", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- INLINE MATH ON NEW LINE
    s(
        { trig = "^mm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("$<>$", {
            i(1),
        })
    ),
    -- FIGURE
    s(
        { trig = "fig" },
        fmta(
            [[
        \begin{figure}[htb!]
          \centering
          \includegraphics[width=<>\linewidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
            {
                i(1),
                i(2),
                i(3),
                i(4),
            }
        ),
        { condition = line_begin }
    ),
    -- Figure environment
    s(
        { trig = "foofig", dscr = "Use 'fig' for figure environmennt, with options" },
        fmta(
            [[
        \begin{figure}<>
          \centering
          \includegraphics<>{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
      ]],
            {
                -- Optional [htbp] field
                c(1, {
                    t([[]]), -- Choice 1, empty
                    t("[htbp]"), -- Choice 2, this may be turned into a snippet
                }, {}),
                -- Options for includegraphics
                c(2, {
                    t([[]]), -- Choice 1, empty
                    sn(
                        3, -- Choice 2, this may be turned into a snippet
                        {
                            t("[width="),
                            i(1),
                            t("\\textwidth]"),
                        }
                    ),
                }, {}),
                i(3, "filename"),
                i(4, "text"),
                i(5, "label"),
            }
        ),
        { condition = line_begin }
    ),
    ------------------------------
    -- Below are firond's snippets
    s(
        { trig = "bf", snippetType = "autosnippet" },
        fmta(
            [[
      \begin{proof}
        <>
      \end{proof}
      ]],
            {
                i(0),
            }
        ),
        { condition = line_begin }
    ),
    s(
        { trig = "box", snippetType = "autosnippet" },
        fmta(
            [[
      \begin{framed}
        <>
      \end{framed}
      ]],
            {
                i(0),
            }
        ),
        { condition = tex.in_text * line_begin }
    ),
    s(
        { trig = "dcase", snippetType = "autosnippet", priority = 2000 },
        fmta(
            [[
      \begin{dcases}
        <>
      \end{dcases}
      ]],
            {
                i(0),
            }
        ),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "case", snippetType = "autosnippet" },
        fmta(
            [[
      \begin{cases}
        <>
      \end{cases}
      ]],
            {
                i(0),
            }
        ),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "bcr", snippetType = "autosnippet" },
        fmta(
            [[
      \begin{center}
        <>
      \end{center}
      ]],
            {
                i(0),
            }
        ),
        { condition = line_begin }
    ),
    s(
        { trig = "btr", snippetType = "autosnippet" },
        fmta(
            [[
      \begin{tabular}{<>}
        \hline
        <>
        \hline
      \end{tabular}
      ]],
            {
                i(1),
                i(0),
            }
        ),
        { condition = line_begin }
    ),
}
