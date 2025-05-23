vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
		end

		--local builtin = require("telescope.builtin")
		local Snacks = require("snacks")

		map("gd", function()
			Snacks.picker.lsp_definitions()
		end, "[G]o [D]efinitions")

		map("gD", function()
			Snacks.picker.lsp_declarations()
		end, "[G]o [D]eclarations")

		map("gI", function()
			Snacks.picker.lsp_implementations()
		end, "[G]o [I]mplementation")

		map("gr", function()
			Snacks.picker.lsp_references()
		end, "[G]o [R]eferences")

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<space>rn", vim.lsp.buf.rename, "[R]e[N]ame")
		map("<space>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	end,
})

vim.lsp.enable({
	-- javascript
	"astro",
	"biome",
	"eslint",
	"html",
	"cssls",
	"tailwindcss",
	"ts_ls",
	"emmet_ls",

	"gopls",
	"lua_ls",
	-- scala
	"metals",
	--"pyright",
	"marksman",
	"rust_analyzer",
	"zls",
})
