return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = true,
	opts = {
		options = { theme = "enfocado", globalstatus = true },
		sections = {
			lualine_c = { { "filename", file_status = true, path = 1 } },
		},
		inactive_winbar = {
			lualine_c = { "filename" }
		}
	}
}
