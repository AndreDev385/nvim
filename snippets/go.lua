local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
	s("ife", fmt("if err != nil {{\n\t{}\n}}", { i(1, "body") })),
}

ls.add_snippets("go", snippets)
