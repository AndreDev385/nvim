local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.diagnostic.config({
	underline = {
		severity = {
			[vim.diagnostic.severity.ERROR] = { underline = true, sp = "#FF5555" },
			[vim.diagnostic.severity.WARN] = { underline = true, sp = "#FFB86C" },
			[vim.diagnostic.severity.HINT] = { underline = true, sp = "#8BE9FD" },
			[vim.diagnostic.severity.INFO] = { underline = true, sp = "#BD93F9" },
		},
	},
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
	virtual_text = {
		prefix = "▎",
		spacing = 2,
		format = function(diagnostic)
			local severity = diagnostic.severity
			local icon = severity == vim.diagnostic.severity.ERROR and " "
				or severity == vim.diagnostic.severity.WARN and " "
				or severity == vim.diagnostic.severity.HINT and " "
				or " "
			return string.format("%s %s", icon, diagnostic.message)
		end,
	},
	virtual_lines = false,
	float = {
		border = "rounded",
		focusable = true,
		style = "minimal",
		source = "always",
		header = "",
		prefix = "",
		max_width = 80,
		max_height = 20,
		winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
	},
	severity_sort = true,
})

require("config.options")
require("config.keymaps")

require("lazy").setup({ import = "plugins" }, {
	change_detection = { notify = false },
})
