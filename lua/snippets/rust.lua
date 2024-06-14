local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rust", {
	s("prt", fmt('println!("{}", {})', { i(1), i(0) })),
})

print("rust snippets loaded")
