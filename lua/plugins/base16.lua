return {
	"wincent/base16-nvim",
	lazy = false, -- load at start
	priority = 1000, -- load first
	config = function()
		vim.o.background = "dark"
		vim.cmd([[colorscheme ayu-dark]])
		vim.cmd([[hi Normal ctermbg=NONE]])
		-- Less visible window separator
		vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })
		-- Make comments more prominent -- they are important.
		--local bools = vim.api.nvim_get_hl(0, { name = "Boolean" })
		--vim.api.nvim_set_hl(0, "Comment", bools)
		vim.api.nvim_set_hl(0, "Comment", { fg = "#9e9a85" })
		-- Make it clearly visible which argument we're at.
		local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
		vim.api.nvim_set_hl(
			0,
			"LspSignatureActiveParameter",
			{ fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true }
		)
		-- XXX
		-- Would be nice to customize the highlighting of warnings and the like to make
		-- them less glaring. But alas
		-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
		-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
	end,
}
