---@brief
--- https://github.com/tailwindlabs/tailwindcss-intellisense
---
--- Tailwind CSS Language Server can be installed via npm:
---
--- npm install -g @tailwindcss/language-server
---@type vim.lsp.Config
return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	-- filetypes copied and adjusted from tailwindcss-intellisense
	filetypes = {
		-- html
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir", -- vim ft
		"elixir",
		"ejs",
		"erb",
		"eruby", -- vim ft
		"gohtml",
		"gohtmltmpl",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"htmlangular",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		-- css
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		-- js
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		-- mixed
		"vue",
		"svelte",
		"templ",
	},
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
			},
			includeLanguages = {
				astro = "html",
				eelixir = "html-eex",
				elixir = "phoenix-heex",
				eruby = "erb",
				heex = "phoenix-heex",
				htmlangular = "html",
				templ = "html",
			},
		},
	},
	before_init = function(_, config)
		if not config.settings then
			config.settings = {}
		end
		if not config.settings.editor then
			config.settings.editor = {}
		end
		if not config.settings.editor.tabSize then
			config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
		end
	end,
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local root_files = {
			-- Generic
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
			-- Django
			"theme/static_src/tailwind.config.js",
			"theme/static_src/tailwind.config.cjs",
			"theme/static_src/tailwind.config.mjs",
			"theme/static_src/tailwind.config.ts",
			"theme/static_src/postcss.config.js",
			-- Fallback for tailwind v4, where tailwind.config.* is not required anymore
			".git",
			-- Additional fallbacks
			"package.json",
			"mix.lock",
			"Gemfile.lock",
		}

		local bufname = vim.api.nvim_buf_get_name(bufnr)

		-- If buffer has no name (unnamed buffer), use current working directory
		if bufname == "" then
			on_dir(vim.fn.getcwd())
			return
		end

		local bufdir = vim.fn.fnamemodify(bufname, ":p:h")
		local project_root = nil

		-- Special handling for Astro files
		if string.match(bufname, "%.astro$") then
			-- For Astro files, look for project markers in the work directory
			local workdir = "/home/andre/work/adcendia"
			if vim.fn.isdirectory(workdir) == 1 then
				project_root = workdir
			end
		end

		-- If we haven't found a project root yet, search upward for root files
		if not project_root then
			for _, file in ipairs(root_files) do
				local root = vim.fn.findfile(file, bufdir .. ";")
				if root ~= "" then
					project_root = vim.fn.fnamemodify(root, ":p:h")
					break
				end

				-- Also check for directories (for .git directory)
				root = vim.fn.finddir(file, bufdir .. ";")
				if root ~= "" then
					project_root = vim.fn.fnamemodify(root, ":p:h")
					break
				end
			end
		end

		-- If no root file found, use the directory of the file
		if not project_root then
			project_root = bufdir
		end

		on_dir(project_root)
	end,
}
