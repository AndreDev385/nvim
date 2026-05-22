return {
	-- Theme
	{ "vague2k/vague.nvim" },
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	-- File explorer
	{ "stevearc/oil.nvim", keys = {
		{
			"-",
			":Oil<CR>",
			"Open file tree",
		},
	} },
	-- Picker
	{
		"nvim-mini/mini.nvim",
		config = function()
			require("mini.extra").setup({})
		end,
		keys = {
			{ "<leader>sf", ":Pick files<CR>", desc = "Search Files" },
			{ "<leader>sb", ":Pick buffers<CR>", desc = "Search Buffers" },
			{ "<leader>sg", ":Pick grep<CR>", desc = "Search Grep" },
			{ "<leader>sh", ":Pick help<CR>", desc = "Search Help" },
			{
				"<leader>sd",
				function()
					require("mini.extra").pickers.diagnostic()
				end,
				desc = "Search Help",
			},
		},
	},
	-- LSP
	{ "mason-org/mason.nvim" },
	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter" },
	-- Statusline
	{ "windwp/windline.nvim" },
	-- CMP
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-git" },
	{ "hrsh7th/cmp-emoji" },
	-- Autopairs
	{ "windwp/nvim-autopairs" },
	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	-- Surround
	{ "kylechui/nvim-surround" },
	-- Git
	{ "lewis6991/gitsigns.nvim" },
	{ "tpope/vim-fugitive" },
	-- Notes
	{
		"nvim-orgmode/orgmode",
		version = "0.7.0",
		ft = { "org " },
		config = function()
			local Menu = require("org-modern.menu")
			require("orgmode").setup({
				org_agenda_files = "~/org/**/*",
				org_default_notes_file = "~/org/refile.org",
				ui = {
					menu = {
						handler = function(data)
							Menu:new({
								window = {
									margin = { 1, 0, 1, 0 },
									padding = { 0, 1, 0, 1 },
									title_pos = "center",
									border = "single",
									zindex = 1000,
								},
								icons = {
									separator = "➜",
								},
							}):open(data)
						end,
					},
				},
			})

			vim.lsp.enable("org")
		end,
	},
	{
		"chipsenkbeil/org-roam.nvim",
		version = "0.2.0",
		config = function()
			require("org-roam").setup({
				directory = "~/org",
				org_files = { "~/org" },
			})
		end,
	},
	{ "nvim-orgmode/org-bullets.nvim" },
	{
		"lukas-reineke/headlines.nvim",
		config = function()
			require("headlines").setup()
		end,
	},
	{ "danilshvalov/org-modern.nvim" },
	-- Harpoon
	{ "nvim-lua/plenary.nvim" },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- Undotree
	{ "mbbill/undotree" },
	-- conform formatter
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				dart = { "dart_format" },
				lua = { "stylua" },
				odin = { "odinfmt" },
				zig = { "zigfmt" },
				go = { "gofmt" },
				typescript = { "oxlint", "oxfmt" },
				svelte = { "eslint", "prettier" },
				python = { "ruff_format" },
				html = { "prettier" },
				css = { "prettier" },
				markdown = { "marksman" },
				["*"] = { "codespell" },
			},
		},
	},
	-- degbuggers
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("dap-python").setup("python3") -- O la ruta a tu venv
			require("nvim-dap-virtual-text").setup()
			require("dapui").setup()

			local dap = require("dap")

			---@diagnostic disable-next-line: undefined-field
			dap.adapters.python = {
				type = "executable",
				command = "python", -- o la ruta a tu venv: '/home/user/.virtualenvs/debugpy/bin/python'
				args = { "-m", "debugpy.adapter" },
			}

			---@diagnostic disable-next-line: undefined-field
			dap.configurations.python = {
				{
					-- Escenario 1: Lanzar el archivo actual
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						return "/usr/bin/python3" -- O una función que detecte tu venv
					end,
				},
				{
					-- Escenario 2: Engancharse a un servidor corriendo (Attach)
					type = "python",
					request = "attach",
					name = "Attach remote",
					connect = {
						port = 5678,
						host = "127.0.0.1",
					},
				},
			}
		end,
		keys = {
			{
				"<leader>db",
				function()
					---@diagnostic disable-next-line: undefined-field
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dsi",
				function()
					---@diagnostic disable-next-line: undefined-field
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<leader>dso",
				function()
					---@diagnostic disable-next-line: undefined-field
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<leader>dc",
				function()
					---@diagnostic disable-next-line: undefined-field
					require("dap").continue()
				end,
				desc = "Continue",
			},
		},
	},
}
