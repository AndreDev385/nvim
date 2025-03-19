local js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

return {
	{ "nvim-neotest/nvim-nio" },
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- dap ui
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- JS
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						".local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
			dap.adapters.firefox = {
				type = "executable",
				command = "node",
				args = {
					os.getenv("HOME")
						.. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
				},
			}

			-- JS
			for _, language in ipairs(js_based_languages) do
				dap.configurations[language] = {
					-- Debug single nodejs files
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
					},
					-- Debug nodejs processes (make sure to add --inspect when you run the process)
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
					},
					-- Debug web applications (client side)
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch & Debug Chrome",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
					-- Divider for the launch.json derived configs
					{
						name = "----- ↓ launch.json configs ↓ -----",
						type = "",
						request = "launch",
					},
				}
			end
			-- End JS
			--
			-- Godot
			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}
			dap.configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch scene",
					project = "${workspaceFolder}",
				},
			}
			-- End Godot

			-- C/C++/Rust
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}
		end,
		keys = {
			{
				"<leader>dt",
				function()
					require("dapui").toggle()
				end,
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				mode = { "n", "v" },
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Condition: "))
				end,
			},
			{
				"<leader>da",
				function()
					if vim.fn.filereadable(".vscode/launch.json") then
						local dap_vscode = require("dap.ext.vscode")
						dap_vscode.load_launchjs(nil, {
							["pwa-node"] = js_based_languages,
							["chrome"] = js_based_languages,
							["pwa-chrome"] = js_based_languages,
						})
					end
					require("dap").continue()
				end,
				desc = "Run with Args",
			},
		},
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "rcarriga/nvim-dap-ui" },
			{
				"mxsdev/nvim-dap-vscode-js",
				opts = {
					adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
					debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
				},
			},
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps; npm run compile vsDebugServerBundle; mv dist out",
				version = "1.*",
			},
			{ "jbyuki/one-small-step-for-vimkind", keys = { "<leader>dL", "<leader>dT" } },
			{
				"leoluz/nvim-dap-go",
				opts = {
					dap_configurations = {
						{
							-- Must be "go" or it will be ignored by the plugin
							type = "go",
							name = "Attach remote",
							mode = "remote",
							request = "attach",
						},
					},
					delve = {
						path = "dlv",
						initialize_timeout_sec = 20,
						port = "${port}",
						args = {},
						build_flags = "",
						detached = vim.fn.has("win32") == 0,
					},
					tests = {
						verbose = false,
					},
				},
			},
			{
				"Joakker/lua-json5",
				build = "./install.sh",
			},
		},
	},
}
