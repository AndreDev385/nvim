return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false,
	opts = {
		provider = "openai",
		providers = {
			openai = {
				endpoint = "https://api.z.ai/api/paas/v4",
				model = "glm-4.5",
				api_key_name = "ZAI_API_KEY",
				timeout = 30000,
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 4096,
				},
			},
		},
		windows = {
			position = "right",
			width = 30,
			wrap = true,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"MeanderingProgrammer/render-markdown.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
