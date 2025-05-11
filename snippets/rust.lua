local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
	s("prt", fmt('println!("{}", {})', { i(1), i(0) })),
}

return {
	filetype = "rust",
	snippets,
}
