return {
	"mistweaverco/kulala.nvim",
	opts = {},
	ft = { "http", "rest" },
	keys = {
		{
			"<leader>rx",
			function()
				require("kulala").run()
			end,
			desc = "Send request",
		},
		{
			"<leader>ra",
			function()
				require("kulala").run_all()
			end,
			desc = "Send all requests",
		},
		{
			"<leader>p",
			function()
				require("kulala").jump_prev()
			end,
			desc = "Jump to prev request",
		},
		{
			"<leader>n",
			function()
				require("kulala").jump_next()
			end,
			desc = "Jump to next request",
		},
	},
}
