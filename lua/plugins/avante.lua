return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this to "*"
	opts = {
		provider = "openrouter",
		providers = {
			openrouter = {
				__inherited_from = "openai",
				endpoint = "https://openrouter.ai/api/v1",
				model = "openrouter/auto",
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
			sidebar_header = {
				enabled = true,
				align = "center",
				rounded = true,
			},
			spinner = {
				editing = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
				generating = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
				thinking = { "🤔", "💭", "💡" },
			},
			input = {
				prefix = "> ",
				height = 8,
			},
			edit = {
				border = "rounded",
				start_insert = true,
			},
			ask = {
				floating = false,
				start_insert = true,
				border = "rounded",
				focus_on_apply = "ours",
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"MeanderingProgrammer/render-markdown.nvim",
		-- Optional dependencies
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
