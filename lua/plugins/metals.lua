return {
	"scalameta/nvim-metals",
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals_config = require("metals").bare_config()

		metals_config.on_attach = function(_, _)
			require("metals").setup_dap()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation)

			vim.keymap.set("n", "gr", builtin.lsp_references)
			vim.keymap.set("n", "K", vim.lsp.buf.hover)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)

			vim.keymap.set("n", "<leader>mc", function()
				require("telescope").extensions.metals.commands()
			end)
		end

		-- Reduce verbosity of messages and enhance project loading
		metals_config.settings = {
			metals = {
				serverProperties = {
					"-Dmetals.log-level=error", -- Use error level to reduce verbosity
				},
				testUserInterface = "Test Explorer",
				autoImportBuild = "all", -- Automatically import build changes
				--fallbackScalaVersion = "2.13.16", -- Set fallback Scala version for new projects
				defaultBspToBuildTool = true, -- Use build tool as BSP server instead of Bloop
				verboseCompilation = true, -- Enable detailed compilation logs
				inlayHints = {
					byNameParameters = { enable = true },
					hintsInPatternMatch = { enable = true },
					implicitArguments = { enable = true },
					implicitConversions = { enable = true },
					inferredTypes = { enable = true },
					typeParameters = { enable = true },
				},
				superMethodLensesEnabled = true, -- Enable super method lenses
				enableSemanticHighlighting = true, -- Enable semantic highlighting
				icons = {
					error = "",
					warn = "",
					info = "",
					debug = "",
					trace = "",
				},
			},
		}

		-- Suppress status notifications
		metals_config.init_options = {
			statusBarProvider = "off", -- Disable status bar updates
			isHttpEnabled = true,
			compilerOptions = {
				snippetAutoIndent = true,
			},
		}

		return metals_config
	end,
	config = function(self, metals_config)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

		-- Disable LSP progress messages
		vim.api.nvim_create_autocmd("LspProgress", {
			callback = function(ev)
				-- Filter out Metals progress messages
				if ev.data.client_id and vim.lsp.get_client_by_id(ev.data.client_id).name == "metals" then
					return true -- Suppress the message
				end
			end,
			group = nvim_metals_group,
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}
