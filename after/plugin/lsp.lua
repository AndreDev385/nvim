vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
		end

		local builtin = require("telescope.builtin")

		map("gd", builtin.lsp_definitions, "[G]o [D]efinitions")
		map("gD", vim.lsp.buf.declaration, "[G]o [D]eclarations")
		map("gI", builtin.lsp_implementations, "[G]o [I]mplementation")
		map("gr", builtin.lsp_references, "[G]o [R]eferences")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<space>rn", vim.lsp.buf.rename, "[R]e[N]ame")
		map("<space>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	end,
})

vim.lsp.enable({
	"astro",
	"biome",
	"cssls",
	"eslint",
	--"gopls",
	"html",
	"lua_ls",
	"metals",
	--"pyright",
	--"rust_analyzer",
	"tailwindcss",
	"ts_ls",
	"zls",
})
