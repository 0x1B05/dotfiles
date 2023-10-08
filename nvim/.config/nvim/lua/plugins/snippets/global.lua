local ls = require("luasnip")

local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local extras = require("luasnip.extras")
local fmt = extras.fmt
local rep = extras.rep

-- local isn = ls.indent_snippet_node
-- local r = ls.restore_node
-- local events = require "luasnip.util.events"
-- local ai = require "luasnip.nodes.absolute_indexer"
-- local m = extras.m
-- local l = extras.l
-- local postfix = require "luasnip.extras.postfix".postfix

vim.keymap.set({ "i", "s" }, "<a-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
vim.keymap.set({ "i", "s" }, "<a-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

local snippets, autosnippets = {}, {}

local myFirstSnippet = s("myFirstSnippet", t("Hi! This is my first snippet in LuaSnip"))

table.insert(snippets, myFirstSnippet)

return snippets, autosnippets
