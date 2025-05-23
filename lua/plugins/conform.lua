return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofmt" },
			--["*"] = { "codespell" },
			astro = { "prettier", "biome" },
			--typescript = { "biome", "prettier" },
			--typescriptreact = { "biome", "prettier" },
			--javascript = { "biome", "prettier" },
			--javascriptreact = { "biome", "prettier" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			javascript = { "biome" },
			javascriptreact = { "biome" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
	},
}
