local ls = require("luasnip")
local helpers = require("util.luasnip")
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
	s(
		"date",
		f(function()
			return os.date("%D - %H:%M")
		end)
	),
	s("choicenode", c(1, { t("choice 1"), t("choice 2"), t("choice 3") })),
}
