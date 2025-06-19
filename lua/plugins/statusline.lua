return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Define colors for atelier-dune theme
		local colors = {
			gui00 = "#20201d", -- Background
			gui01 = "#292824", -- Darker foreground
			gui02 = "#6e6b5e", -- Selection background
			gui03 = "#7d7a68", -- Comments, invisibles
			gui04 = "#999580", -- Dark foreground
			gui05 = "#a6a28c", -- Default foreground
			gui06 = "#e8e4cf", -- Light foreground
			gui07 = "#fefbec", -- Light background
			gui08 = "#d73737", -- Red (variables, parameters, tags)
			gui09 = "#b65611", -- Orange (integers, booleans)
			gui0A = "#ae9513", -- Yellow (classes, search text)
			gui0B = "#60ac39", -- Green (strings)
			gui0C = "#1fad83", -- Cyan (escape characters, regex)
			gui0D = "#6684e1", -- Blue (functions, methods)
			gui0E = "#b854d4", -- Purple (keywords, storage, selector)
			gui0F = "#d43552", -- Magenta (deprecated, opening/closing)
		}

		-- Define lualine theme using atelier-dune colors
		local atelier_dune_theme = {
			normal = {
				a = { fg = colors.gui01, bg = colors.gui0D, gui = "bold" }, -- Blue background for mode
				b = { fg = colors.gui0D, bg = colors.gui01 },               -- Darker background for branch
				c = { fg = colors.gui05, bg = colors.gui01 },               -- Normal background
			},
			insert = {
				a = { fg = colors.gui01, bg = colors.gui0B, gui = "bold" }, -- Green background for insert mode
				b = { fg = colors.gui0B, bg = colors.gui01 },
				c = { fg = colors.gui05, bg = colors.gui01 },
			},
			visual = {
				a = { fg = colors.gui01, bg = colors.gui0E, gui = "bold" }, -- Purple background for visual mode
				b = { fg = colors.gui0E, bg = colors.gui01 },
				c = { fg = colors.gui05, bg = colors.gui01 },
			},
			replace = {
				a = { fg = colors.gui01, bg = colors.gui08, gui = "bold" }, -- Red background for replace mode
				b = { fg = colors.gui08, bg = colors.gui01 },
				c = { fg = colors.gui05, bg = colors.gui01 },
			},
			command = {
				a = { fg = colors.gui01, bg = colors.gui0A, gui = "bold" }, -- Yellow background for command mode
				b = { fg = colors.gui0A, bg = colors.gui01 },
				c = { fg = colors.gui05, bg = colors.gui01 },
			},
			inactive = {
				a = { fg = colors.gui03, bg = colors.gui01 },
				b = { fg = colors.gui03, bg = colors.gui01 },
				c = { fg = colors.gui03, bg = colors.gui01 },
			},
		}

		require("lualine").setup({
			options = {
				theme = atelier_dune_theme,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󰟃 ",
						},
					},
					{
						"filetype",
						icon_only = true,
						colored = true,
					},
					{
						"filename",
						file_status = true,
						path = 1,
					},
				},
				lualine_x = { "encoding", "fileformat" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "nvim-tree", "fugitive" },
		})
	end,
}
