return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
			{ "nvim-telescope/telescope-symbols.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		--keys = {
		--	{
		--		"<leader>sf",
		--		function()
		--			require("telescope.builtin").find_files({ hidden = true })
		--		end,
		--		desc = "[S]earch [F]iles",
		--	},
		--	{
		--		"<leader>sb",
		--		function()
		--			require("telescope.builtin").buffers()
		--		end,
		--		desc = "[ ] Find existing buffers",
		--	},
		--	{
		--		"<leader>/",
		--		function()
		--			-- You can pass additional configuration to telescope to change theme, layout, etc.
		--			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		--				winblend = 10,
		--				previewer = false,
		--			}))
		--		end,
		--		desc = "[/] Fuzzily search in current buffer",
		--	},
		--	{
		--		"<leader>ss",
		--		function()
		--			require("telescope.builtin").builtin()
		--		end,
		--		{ desc = "[S]earch [S]elect Telescope" },
		--	},
		--	{
		--		"<leader>gf",
		--		function()
		--			require("telescope.builtin").git_files()
		--		end,
		--		desc = "Search [G]it [F]iles",
		--	},
		--	{
		--		"<leader>sh",
		--		function()
		--			require("telescope.builtin").help_tags()
		--		end,
		--		desc = "[S]earch [H]elp",
		--	},
		--	{
		--		"<leader>sg",
		--		function()
		--			require("telescope").extensions.live_grep_args.live_grep_args()
		--		end,
		--		{ desc = "[S]earch by [G]rep" },
		--	},
		--	{
		--		"<leader>sd",
		--		function()
		--			require("telescope.builtin").diagnostics()
		--		end,
		--		desc = "[S]earch [D]iagnostics",
		--	},
		--},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local trouble = require("trouble.sources.telescope")

			local layout_config = {
				height = 0.6,
				width = 0.5,
			}

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-t>"] = trouble.open,
						},
						n = {
							["<C-t>"] = trouble.open,
						},
					},
				},
				previewer = false,
				pickers = {
					find_files = {
						previewer = false,
						layout_config = layout_config,
					},
					git_files = {
						previewer = false,
						layout_config = layout_config,
					},
					buffers = {
						previewer = false,
						layout_config = layout_config,
					},
					live_grep = {
						previewer = true,
						layout_config = layout_config,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- load extensions last
			telescope.load_extension("live_grep_args")
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
	},
}
