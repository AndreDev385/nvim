function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
	vim.cmd([[highlight Folded guibg=none]])
end

ColorMyPencils()
