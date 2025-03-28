local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local tex = require("util.latex")

-- A logical OR of `line_begin` and the regTrig '[^%a]trig'
function line_begin_or_non_letter(line_to_cursor, matched_trigger)
    local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
    local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
    return line_begin or non_letter
end

local line_begin = function(line_to_cursor, matched_trigger)
    -- +1 because `string.sub("abcd", 1, -2)` -> abc
    return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

-- Return snippet tables
return {
    -- TYPEWRITER i.e. \texttt
    s(
        { trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
        fmta("<>\\texttt{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_text }
    ),
    -- ITALIC i.e. \textit
    s(
        { trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\textit{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- BOLD i.e. \textbf
    s(
        { trig = "tbb", snippetType = "autosnippet" },
        fmta("\\textbf{<>}", {
            d(1, get_visual),
        })
    ),
    -- MATH ROMAN i.e. \mathrm
    s(
        { trig = "([^%a])mrm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathrm{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- MATH CALIGRAPHY i.e. \mathcal
    s(
        { trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathcal{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- MATH BOLDFACE i.e. \mathbf
    s(
        { trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathbf{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- MATH BLACKBOARD i.e. \mathbb
    s(
        { trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathbb{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- REGULAR TEXT i.e. \text (in math environments)
    s(
        { trig = "([^%a])tee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\text{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    ----------------------------------
    -- Below are firond's snippets
    s(
        { trig = "msf", snippetType = "autosnippet", priority = 2000 },
        fmta("\\mathsf{<>}", {
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "msf", snippetType = "autosnippet" },
        fmta("\\mathsf{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "scr", snippetType = "autosnippet", priority = 2000 },
        fmta("\\mathscr{<>}", {
            d(1, get_visual),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "scr", snippetType = "autosnippet" },
        fmta("\\mathscr{<>}", {
            i(0),
        }),
        { condition = tex.in_mathzone }
    ),
    s(
        { trig = "qq", snippetType = "autosnippet", priority = 2000 },
        fmta("\\text{\\ <>\\ }", {
            d(1, get_visual),
        }, { conditon = tex.in_mathzone })
    ),
    s(
        { trig = "tet", snippetType = "autosnippet" },
        fmta("\\text{<>}", {
            i(0),
        })
    ),
}
