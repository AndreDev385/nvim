return {
	"L3MON4D3/LuaSnip",
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	build = "make install_jsregexp",
	opts = function(_, opts)
		local ls = require("luasnip")
		local s = ls.snippet
		local i = ls.insert_node

		local fmt = require("luasnip.extras.fmt").fmt

		local javascript_snippets = {
			s({ trig = "cl", name = "console.log" }, fmt("console.log({})", { i(1, "log") })),
			s(
				"if",
				fmt(
					[[
				if ({}) {{
					{}
				}}
			]],
					{ i(1, "predicate"), i(0, "body") }
				)
			),
			s(
				"forof",
				fmt(
					[[
				for (const {} of {}) {{
					{}
				}}
			]],
					{ i(1, "value"), i(2, "iterable"), i(0, "body") }
				)
			),
			s(
				"fori",
				fmt(
					[[
				for (const idx of {}) {{
					{}
				}}
			]],
					{ i(1, "iterable"), i(0, "body") }
				)
			),
			s(
				"try",
				fmt(
					[[
				try {{
					{}
				}} catch ({}) {{
					{}
				}}
			]],
					{ i(0, "body"), i(1, "error"), i(2, "handler") }
				)
			),
		}

		local react_snippets = {
			s(
				"rdfc",
				fmt(
					[[
			export default function {}() {{
				return (
					<div>
						<h1>{}</h1>
					</div>
				)
			}}
			]],
					{ i(1, "Component"), i(2, "body") }
				)
			),
			s(
				"rfc",
				fmt(
					[[
			export function {}() {{
				return (
					<div>
						<h1>{}</h1>
					</div>
				)
			}}
			]],
					{ i(1, "Component"), i(2, "body") }
				)
			),
		}

		local go_snippets = {
			s(
				"fun",
				fmt(
					[[func {}({}){{
	{}
}}]],
					{ i(1, "name"), i(2, "params"), i(3, "body") }
				)
			),
			s(
				"ife",
				fmt(
					[[if err != nil {{
	return err
}}
{}]],
					{ i(0) }
				)
			),
			s(
				"for",
				fmt(
					[[for key, value := range {} {{
	{}
}}]],
					{ i(1, "list"), i(0, "body") }
				)
			),
		}

		local scala_snippets = {
			s(
				{ trig = "main", name = "main function" },
				fmt(
					[[
				def main(args: Array[String]): Unit = {{
					{}
				}}
			]],
					{ i(1, "code") }
				)
			),
		}

		ls.add_snippets("javascript", javascript_snippets)
		ls.add_snippets("typescript", javascript_snippets)
		ls.add_snippets("javascriptreact", javascript_snippets)
		ls.add_snippets("typescriptreact", javascript_snippets)
		ls.add_snippets("javascriptreact", react_snippets)
		ls.add_snippets("typescriptreact", react_snippets)
		ls.add_snippets("go", go_snippets)
		ls.add_snippets("scala", scala_snippets)

		return opts
	end,
}
