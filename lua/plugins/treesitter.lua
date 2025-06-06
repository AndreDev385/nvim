return {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-context",
	build = ":TSUpdate",
	run = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
	dependencies = {
		-- NOTE: additional parser
		{ "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
	},
	config = vim.defer_fn(function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				"http",
				"c",
				"cpp",
				"go",
				"python",
				"rust",
				"tsx",
				"javascript",
				"typescript",
				"vimdoc",
				"vim",
				"bash",
				"templ",
				"markdown",
				"markdown_inline",
			},
			folds = {
				enable = true, -- Habilita el plegado basado en treesitter
				disable = { "help" }, -- Puedes deshabilitarlo para ciertos tipos de archivo si lo deseas
			},
			auto_install = false,
			sync_install = false,
			ignore_install = {},
			modules = {},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end, 0),
}
