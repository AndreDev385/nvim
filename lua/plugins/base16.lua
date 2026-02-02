return {
	"wincent/base16-nvim",
	lazy = false, -- load at start
	priority = 1000, -- load first
	config = function()
		vim.o.background = "dark"
		vim.cmd([[colorscheme default-dark]])
		vim.api.nvim_set_hl(0, "Comment", { fg = "#9e9a85" })
		local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
		vim.api.nvim_set_hl(
			0,
			"LspSignatureActiveParameter",
			{ fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true }
		)

		-- Obtener colores del tema actual y aplicarlos a números de línea
		local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
		local line_nr_fg = vim.api.nvim_get_hl(0, { name = "LineNr" }).fg
		local cursor_line_nr_fg = vim.api.nvim_get_hl(0, { name = "CursorLineNr" }).fg

		-- Si los colores no existen, usar valores por defecto
		normal_bg = normal_bg or "NONE"
		line_nr_fg = line_nr_fg or "#6e6a86"
		cursor_line_nr_fg = cursor_line_nr_fg or "#908caa"

		vim.api.nvim_set_hl(0, 'LineNr', { fg = line_nr_fg, bg = normal_bg })
		vim.api.nvim_set_hl(0, 'SignColumn', { fg = line_nr_fg, bg = normal_bg })
		vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = cursor_line_nr_fg, bg = normal_bg })
	end,
}
