return {
	cmd = { "emmet-ls", "--stdio" },
	filetypes = {
		"astro",
		"css",
		"eruby",
		"html",
		"htmldjango",
		"javascriptreact",
		"less",
		"pug",
		"sass",
		"scss",
		"svelte",
		"typescriptreact",
		"vue",
		"htmlangular",
		"templ",
	},
	settings = {
		["emmet.ls"] = {
			excludeLanguages = {},
			extensionsPath = {},
			jsxExceptions = { "div", "span", "h1", "h2", "h3", "h4", "h5", "h6", "p", "button" },
			preferences = {
				["output.reverseAttributes"] = false,
				["stylesheet.indent"] = "\t",
				["stylesheet.keywordAfterValue"] = true,
			},
			showAbbreviationSuggestions = true,
			showExpandedAbbreviation = "always",
			showSuggestionsAsSnippets = false,
			syntaxProfiles = {},
			variables = {},
		},
	},
	root_dir = function(fname)
		return vim.fn.fnamemodify(fname, ":p:h")
	end,
}
