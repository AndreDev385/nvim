return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	enabled = true,
	---@module 'render-markdown'
	opts = {
		completions = { blink = { enabled = true } },
		bullet = {
			enabled = true,
		},
		checkbox = {
			enabled = true,
			unchecked = {
				icon = "󰄱 ",
				highlight = "RenderMarkdownUnchecked",
				scope_highlight = nil,
			},
			checked = {
				icon = "󰱒 ",
				highlight = "RenderMarkdownChecked",
				scope_highlight = nil,
			},
		},
		html = {
			enabled = true,
			comment = {
				conceal = false,
			},
		},
		link = {
			image = vim.g.neovim_mode == "skitty" and "" or "󰥶 ",
			custom = {
				youtu = { pattern = "youtu%.be", icon = "󰗃 " },
			},
		},
		heading = {
			sign = false,
			icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
		},
	},
}
