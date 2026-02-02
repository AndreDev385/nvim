return {
	"preservim/nerdtree",
	dependencies = {
		"ryanoasis/vim-devicons",
		"Xuyuanp/nerdtree-git-plugin",
	},
	config = function()
		vim.g.webdevicons_enable_nerdtree = 1
		vim.g.NERDTreeGitStatusUseNerdFonts = 1
		vim.g.NERDTreeWinSize = 50
	end,
	keys = {
		{ "<leader>nt", ":NERDTreeToggle<cr>", desc = "Focus on nerdtree" }
	},
}
