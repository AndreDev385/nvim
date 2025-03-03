return {
	"mistweaverco/kulala.nvim",
	opts = {},
	config = function()
		vim.keymap.set("n", "<leader>rx", "<cmd>lua require('kulala').run()<cr>")
		vim.keymap.set("n", "<leader>p", "<cmd>lua require('kulala').jump_prev()<cr>")
		vim.keymap.set("n", "<leader>n", "<cmd>lua require('kulala').jump_next()<cr>")
	end,
}
