return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			-- Autoformatting
			"stevearc/conform.nvim",
			-- Schema information
			"b0o/SchemaStore.nvim",
		},
	},
}
