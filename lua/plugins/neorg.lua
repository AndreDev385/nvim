return {
	"nvim-neorg/neorg",
	dependencies = { "luarocks.nvim" },
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {
					config = {
						icons = {
							heading = {
								enabled = true,

								level_1 = {
									enabled = true,
									icon = "◉",
								},
								level_2 = {
									enabled = true,
									icon = " ○",
								},
								level_3 = {
									enabled = true,
									icon = "  ●",
								},
								level_4 = {
									enabled = true,
									icon = "   ○",
								},
							},
						},
					},
				},

				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/notes",
						},
						default_workspace = "notes",
					},
				},
			},
		})
	end,
	run = ":Neorg sync-parsers",
}
