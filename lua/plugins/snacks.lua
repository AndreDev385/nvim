return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = { enabled = true },
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		dashboard = { enabled = true },
		gitbrowse = { enabled = true },
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 10, total = 100 },
			},
		},
		statuscolumn = { enabled = true },
		words = { enabled = true },
		zen = { enabled = true },
		picker = {
			enabled = true,
			sort = {
				fields = { "score:desc", "#text", "idx" },
			},
			debug = {
				scores = false,
			},
			matcher = {
				frecency = true,
			},
			win = {
				input = {
					keys = {
						-- to close the picker on ESC instead of going to normal mode,
						-- add the following keymap to your config
						-- ["<Esc>"] = { "close", mode = { "n", "i" } },
						-- I'm used to scrolling like this in LazyGit
						["J"] = { "preview_scroll_down", mode = { "i", "n" } },
						["K"] = { "preview_scroll_up", mode = { "i", "n" } },
						["H"] = { "preview_scroll_left", mode = { "i", "n" } },
						["L"] = { "preview_scroll_right", mode = { "i", "n" } },
					},
				},
			},
			formatters = {
				file = {
					filename_first = true, -- display filename before the file path
					truncate = 80,
				},
			},
		},
	},
	keys = {
		{
			"<leader>sf",
			function()
				Snacks.picker.files({
					finder = "files",
					format = "file",
					show_empty = true,
					supports_live = true,
				})
			end,
			desc = "[S]earch [F]iles",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[ ] Find existing buffers",
		},
		{
			"<leader>sg",
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				Snacks.picker.grep()
			end,
			desc = "[/] Fuzzily search in current buffer",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker()
			end,
			{ desc = "[S]earch [S]elect Telescope" },
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Search [G]it [F]iles",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
	},
}
