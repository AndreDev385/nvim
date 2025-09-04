return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = false,
			integration_default = false,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				lsp_trouble = true,
				which_key = true,
				dap = {
					enabled = true,
					enable_ui = true,
				},
				mason = true,
				treesitter = true,
				render_markdown = true,
				notify = true,
				mini = true,
				aerial = true,
				vimwiki = true,
				overseer = true,
				hop = true,
				navic = {
					enabled = true,
					custom_bg = "NONE",
				},
				neotest = true,
				lsp_saga = true,
				barbecue = {
					dim_dirname = true,
					bold_font = false,
					diagnostic = true,
				},
			},
			color_overrides = {},
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.overlay1 },
					CursorLineNr = { fg = colors.pink },
					["@variable"] = { fg = colors.text },
				}
			end,
		})

		--vim.cmd.colorscheme("catppuccin")
	end,
}
