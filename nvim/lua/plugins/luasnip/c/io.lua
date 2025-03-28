local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    -- PRINTF
    s(
        { trig = "pp", snippetType = "autosnippet" },
        fmta([[printf("<>"<>);]], {
            i(1),
            i(2),
        }),
        { condition = line_begin }
    ),
    -- GETLINE BOILERPLATE
    s(
        { trig = "gll", snippetType = "autosnippet" },
        fmta(
            [[
      char *line = NULL;
      size_t len = 0;
      ssize_t nread;
      nread = getline(&line, &len, stdin);
      <>
      free(line);
      ]],
            { i(0) }
        )
    ),
}
