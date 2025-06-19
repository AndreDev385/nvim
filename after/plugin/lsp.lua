-- Load and setup all custom LSP configurations
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
	root_markers = { ".git" },
})

vim.lsp.enable({
	"astro",
	"cssls",
	"emmet_ls",
	"gopls",
	"html",
	"lua_ls",
	"marksman",
	"pyright",
	"rust_analyzer",
	"sqlls",
	"tailwindcss",
	"ts_ls",
	"zls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "[G]o [D]efinitions" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "[G]o [D]eclarations" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf, desc = "[G]o [I]mplementation" })

		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf, desc = "[G]o [R]eferences" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, desc = "Hover Documentation" })
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame" })
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "[C]ode [A]ction" })
	end,
})
