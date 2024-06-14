return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			require("nvim-dap-virtual-text").setup({
				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
						return "*****"
					end

					if #variable.value > 15 then
						return " " .. string.sub(variable.value, 1, 15) .. "... "
					end

					return " " .. variable.value
				end,
			})

			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<F1>", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F13>", dap.restart)

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end

			-- Handled by nvim-dap-go
			dap.adapters.go = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- Node
			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = {
					os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js",
				},
			}

			dap.configurations.typescript = {
				{
					request = "launch",
					type = "node2",
					name = "Launch",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					-- For this to work you need to make sure the node process is started with the `--inspect` flag.
					name = "Attach to process",
					type = "node2",
					request = "attach",
					processId = require("dap.utils").pick_process,
					runtimeArgs = { "--loader", "ts-node/esm" },
					runtimeExecutable = "node",
				},
			}
			dap.configurations.javascript = {
				{
					name = "Launch",
					type = "node2",
					request = "launch",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					-- For this to work you need to make sure the node process is started with the `--inspect` flag.
					name = "Attach to process",
					type = "node2",
					request = "attach",
					processId = require("dap.utils").pick_process,
					runtimeArgs = { "--loader", "ts-node/esm" },
					runtimeExecutable = "node",
				},
			}

			local dart_debugger = vim.fn.exepath("dart-debug-adapter")
			if dart_debugger ~= "" then
				dap.adapters.mix_task = {
					type = "mix_task",
					executable = dart_debugger,
					command = "flutter",
					args = { "debug_adapter" },
				}
				dap.configurations.dart = {
					{
						type = "mix_task",
						request = "launch",
						name = "Launch flutter",
						dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
						flutterSdkPath = "/opt/flutter/bin/flutter", -- ensure this is correct
						program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
						cwd = "${workspaceFolder}",
					},
				}
			end

			local codelldb_debug = vim.fn.exepath("codelldb")
			if codelldb_debug ~= "" then
				dap.adapters.mix_task = {
					type = "mix_task",
					executable = codelldb_debug,
				}
				dap.configurations.rust = {
					{
						-- ... the previous config goes here ...,
						initCommands = function()
							-- Find out where to look for the pretty printer Python module
							local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

							local script_import = 'command script import "'
								.. rustc_sysroot
								.. '/lib/rustlib/etc/lldb_lookup.py"'
							local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

							local commands = {}
							local file = io.open(commands_file, "r")
							if file then
								for line in file:lines() do
									table.insert(commands, line)
								end
								file:close()
							end
							table.insert(commands, 1, script_import)

							return commands
						end,
						-- ...,
					},
				}
			end
		end,
	},
}
