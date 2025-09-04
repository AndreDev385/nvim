return {
	"saghen/blink.cmp",
	enabled = true,
	version = "1.*",
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		"moyiz/blink-emoji.nvim",
	},
	opts = function(_, opts)
		opts.enabled = function()
			-- Get the current buffer's filetype
			local filetype = vim.bo[0].filetype
			-- Disable for Telescope buffers
			if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
				return false
			end
			return true
		end

		opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
			min_keyword_length = 0,
			default = { "lsp", "path", "snippets", "buffer", "emoji" },
			providers = {
				lsp = {
					name = "LSP",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					fallbacks = { "buffer" },
					transform_items = function(_, items)
						return vim.tbl_filter(function(item)
							return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
						end, items)
					end,
					opts = { tailwind_color_icon = "██" },
				},
				path = {
					module = "blink.cmp.sources.path",
					fallbacks = { "buffer" },
					opts = {
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				snippets = {
					enabled = true,
					module = "blink.cmp.sources.snippets",
					opts = {
						-- Whether to use show_condition for filtering snippets
						use_show_condition = true,
						-- Whether to show autosnippets in the completion list
						show_autosnippets = true,
					},
				},
				buffer = {
					module = "blink.cmp.sources.buffer",
					score_offset = -3,
					opts = {
						-- default to all visible buffers
						get_bufnrs = function()
							return vim.iter(vim.api.nvim_list_wins())
								:map(function(win)
									return vim.api.nvim_win_get_buf(win)
								end)
								:filter(function(buf)
									return vim.bo[buf].buftype ~= "nofile"
								end)
								:totable()
						end,
						-- buffers when searching with `/` or `?`
						get_search_bufnrs = function()
							return { vim.api.nvim_get_current_buf() }
						end,
					},
				},
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 93, -- the higher the number, the higher the priority
					min_keyword_length = 2,
					opts = { insert = true }, -- Insert emoji (default) or complete its name
					should_show_items = function()
						return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
					end,
				},
			},
		})

		opts.completion = {
			keyword = { range = "prefix" },
			list = { selection = { preselect = false, auto_insert = false } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				window = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				},
			},
		}

		opts.cmdline = {
			enabled = true,
			completion = { menu = { auto_show = true } },
		}

		opts.signature = {
			enabled = true,
			window = {
				border = "rounded",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			},
		}

		opts.snippets = {
			preset = "luasnip",
		}

		opts.keymap = {
			preset = "default",
			["<C-k>"] = { "snippet_forward", "fallback" },
			["<C-j>"] = { "snippet_backward", "fallback" },
		}

		opts.fuzzy = { implementation = "prefer_rust_with_warning" }

		-- Add highlight groups for better visual integration with ayu-dark
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
		vim.api.nvim_set_hl(0, "BlinkCmpLabel", { link = "Pmenu" })
		vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { link = "PmenuSel" })

		return opts
	end,
}
