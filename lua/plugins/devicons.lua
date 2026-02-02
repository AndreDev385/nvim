return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		-- your personnal icons can go here (to override)
		-- you can specify color or cterm_color instead of specifying both of them
		-- DevIcon will be appended to `name`
		override = {
			zsh = {
				icon = "",
				color = "#428850",
				cterm_color = "65",
				name = "Zsh",
			},
		},
		-- globally enable different icons
		color_icons = true,
		default = true,
	},
	config = function(_, opts)
		require("nvim-web-devicons").setup(opts)
	end,
}