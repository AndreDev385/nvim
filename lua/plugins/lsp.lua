return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		-- LSP handler configuration
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		-- Configure diagnostic appearance
		for name, icon in pairs({
			Error = " ",
			Warn = " ",
			Hint = "󰟃 ",
			Info = " ",
		}) do
			local hl = "DiagnosticSign" .. name
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Set up LSP capabilities for autocompletion
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Set up LSP servers
		local lspconfig = require("lspconfig")
		local servers = {
			"rust_analyzer",
			"tsserver",
			"pyright",
			"gopls",
			"lua_ls",
			"html",
			"cssls",
			"emmet_ls",
			"tailwindcss",
			"marksman",
			"sqlls",
			"astro",
		}

		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- Enable inlay hints if supported
					if client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			})
		end

		-- Configure lua_ls specifically for Neovim
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}