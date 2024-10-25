return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-git",
		-- autopairs
		"windwp/nvim-autopairs",
		-- snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	event = "VeryLazy",
	main = "config.completion",
	config = true,
}
