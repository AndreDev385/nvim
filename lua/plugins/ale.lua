return {
	"dense-analysis/ale",
	config = function()
		-- Configuration goes here.
		local g = vim.g

		-- General ALE settings
		g.ale_enabled = 1
		g.ale_fix_on_save = 1
		g.ale_set_highlights = 0 -- Use Neovim's native diagnostic highlights
		g.ale_echo_msg_error_str = "E"
		g.ale_echo_msg_warning_str = "W"
		g.ale_echo_msg_format = "[%linter%] %s [%severity%]"
		g.ale_sign_column_always = 1
		g.ale_sign_error = "●"
		g.ale_sign_warning = "●"

		-- Linters configuration
		g.ale_linters = {
			lua = { "selene", "luacheck" },
			go = { "golangci-lint" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },
			rust = { "analyzer" },
			python = { "flake8", "mypy" },
			markdown = { "markdownlint" },
			json = { "jsonlint" },
			yaml = { "yamllint" },
			html = { "htmlhint" },
			css = { "stylelint" },
		}

		-- Fixers configuration
		g.ale_fixers = {
			lua = { "stylua" },
			go = { "gofmt" },
			javascript = { "biome", "prettier", "eslint" },
			typescript = { "biome", "prettier", "eslint" },
			javascriptreact = { "biome", "prettier", "eslint" },
			typescriptreact = { "biome", "prettier", "eslint" },
			rust = { "rustfmt" },
			python = { "black", "isort" },
			markdown = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			html = { "prettier" },
			css = { "prettier", "stylelint" },
			astro = { "prettier", "biome" },
		}

		-- Language-specific settings
		-- JavaScript/TypeScript
		g.ale_javascript_eslint_use_global = 1
		g.ale_typescript_eslint_use_global = 1

		-- Lua
		g.ale_lua_lua_language_server_config = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}

		-- Rust
		g.ale_rust_analyzer_executable = "rust-analyzer"

		-- Python
		g.ale_python_flake8_options = "--max-line-length=88"
	end,
}
