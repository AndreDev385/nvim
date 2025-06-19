return {
	cmd = { "sql-language-server", "up", "--method", "stdio" },
	filetypes = { "sql", "mysql" },
	root_makers = { ".sqllsrc.json" },
	root_dir = function(fname)
		return vim.fs.root(fname, { ".sqllsrc.json" })
	end,
	settings = {},
}
