local lspkind = require("lspkind")
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local M = {}

-- Enhanced window configuration with better styling
local enhanced_window = {
	completion = cmp.config.window.bordered({
		winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		border = "rounded",
		col_offset = -3,
		side_padding = 1,
		scrollbar = true,
	}),
	documentation = cmp.config.window.bordered({
		winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		border = "rounded",
		max_width = 80,
		max_height = 20,
	}),
}

function M.setup()
	-- Setup vim-dadbod for SQL completions
	cmp.setup.filetype({ "sql" }, {
		sources = {
			{ name = "vim-dadbod-completion" },
			{ name = "buffer" },
		},
		window = enhanced_window,
	})

	-- Main cmp setup with enhanced styling and functionality
	cmp.setup({
		completion = {
			completeopt = "menu,menuone,preview,noselect",
			keyword_length = 1,
		},
		window = enhanced_window,
		sources = {
			{ name = "nvim_lsp", priority = 1000 },
			{ name = "luasnip",  priority = 750 },
			{ name = "path",     priority = 500 },
			{ name = "buffer",   priority = 250 },
			{ name = "emoji",    priority = 700 },
		},
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-y>"] = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Insert,
			}),
			-- Preserve your current snippet navigation keys
			["<C-j>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-k>"] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		-- Enable luasnip to handle snippet expansion for nvim-cmp
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol", -- show only symbol annotations
				maxwidth = 50,
				symbol_map = {
					Supermaven = "🔮",
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈚",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "󰅲",
					Emoji = "󰞱",
				},
				ellipsis_char = "…",
				show_labelDetails = true,
				before = function(entry, vim_item)
					-- Show source in completion item
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
						emoji = "[Emoji]",
					})[entry.source.name]

					-- Add Tailwind color icons if available
					if entry.source.name == "nvim_lsp" and vim_item.documentation and vim_item.documentation:match("tailwind") then
						vim_item.kind = "██"
					end

					return vim_item
				end,
			}),
		},
		-- Enhanced sorting and filtering
		sorting = {
			priority_weight = 2,
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		-- Performance improvements
		performance = {
			max_view_entries = 50,
			debounce = 60,
			throttle = 30,
		},
	})

	-- Enable autopairs integration
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	-- Git commit completions with emoji support
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "git",   priority = 1000 },
			{ name = "emoji", priority = 800 },
		}, {
			{ name = "buffer", priority = 500 },
		}),
		window = enhanced_window,
	})

	-- Enhanced cmdline mapping with <C-y> confirmation
	local cmdline_mapping = {
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-n>"] = {
			c = function()
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end,
		},
		["<C-p>"] = {
			c = function()
				if cmp.visible() then
					cmp.select_prev_item()
				end
			end,
		},
	}

	-- Command line completions with enhanced styling
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmdline_mapping,
		sources = {
			{ name = "buffer" },
		},
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				border = "rounded",
			}),
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmdline_mapping,
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				border = "rounded",
			}),
		},
	})

	-- Set up custom highlight groups for better visual integration
	local setup_highlights = function()
		-- Completion menu highlights
		vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#E6E6FA", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7C7C7C", bg = "NONE", strikethrough = true })
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#5EFF87", bg = "NONE", bold = true })
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#5EFF87", bg = "NONE", bold = true })
		vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#89DDFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#7C7C7C", bg = "NONE", italic = true })

		-- Different kinds with distinct colors
		vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C792EA", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#C792EA", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#C792EA", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#FFCB6B", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFCB6B", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#FFCB6B", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#82AAFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#82AAFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#F07178", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#F07178", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#FFCB6B", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#C3E88D", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#A6ACCD", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#82AAFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#82AAFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#C792EA", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindNamespace", { fg = "#C792EA", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindPackage", { fg = "#C792EA", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#89DDFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#89DDFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#FFCB6B", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F07178", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#F07178", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#82AAFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#FFCB6B", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#82AAFF", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FFCB6B", bg = "NONE" })
	end

	-- Apply highlights
	setup_highlights()

	-- Re-apply highlights on colorscheme change
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = setup_highlights,
	})
end

return M
