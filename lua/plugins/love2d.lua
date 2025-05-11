-- using lazy.nvim
return {
	"S1M0N38/love2d.nvim",
	cmd = "LoveRun",
	opts = {},
	keys = {
		{ "<leader>l2", ft = "lua", desc = "LÖVE" },
		{ "<leader>lr", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
		{ "<leader>ls", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
	},
}
