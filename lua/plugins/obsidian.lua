return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = false,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>oo",
			":cd /home/andre/obsidian<cr>",
			desc = "Go to obsidian directory",
		},
		{
			"<leader>Oy",
			":ObsidianYesterday<cr>",
			desc = "Yesterday's note",
		},
		{
			"<leader>Ot",
			":ObsidianToday<cr>",
			desc = "Today's note",
		},
		{
			"<leader>OT",
			":ObsidianTomorrow<cr>",
			desc = "Tomorrow's note",
		},
		{
			"<leader>ot",
			":ObsidianTags<cr>",
			desc = "Obsidian tags",
		},
		{
			"<leader>on",
			":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
			desc = "build template",
		},
		{
			"<leader>of",
			":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>",
			desc = "Fix note title",
		},
		{
			"<leader>os",
			':Telescope find_files search_dirs={"/home/andre/obsidian/inbox/"}<cr>',
			desc = "Find obsidian files",
		},
		{
			"<leader>oz",
			':Telescope live_grep search_dirs={"/home/andre/obsidian/inbox"}<cr>',
			desc = "Grep obsidian files",
		},
		{
			"<leader>odd",
			":!rm '%:p'<cr>:bd<cr>",
			desc = "delete current buffer",
		},
	},
	opts = {
		workspaces = {
			{
				name = "obsidian",
				path = "/home/andre/obsidian",
			},
		},
		notes_subdir = "inbox",
		daily_notes = {
			folder = "daily",
			date_format = "%Y-%m-%d",
			alias_format = "%B %-d, %Y",
			default_tags = { "daily-notes" },
			template = "daily",
		},
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M:%S",
		},
		log_level = vim.log.levels.INFO,
		completion = {},
		mappings = {
			--	--Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			--	["gf"] = {
			--		action = function()
			--			return require("obsidian").util.gf_passthrough()
			--		end,
			--		opts = { noremap = false, expr = true, buffer = true },
			--	},
			--	--Smart action depending on context, either follow link or toggle checkbox.
			--	["<cr>"] = {
			--		action = function()
			--			return require("obsidian").util.smart_action()
			--		end,
			--		opts = { buffer = true, expr = true },
			--	},
		},
		new_notes_location = "notes_subdir",
		preferred_link_style = "wiki",
		picker = {
			name = "telescope.nvim",
			mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
		},
		ui = {
			enable = false, -- set to false to disable all additional syntax features
		},
	},
}
