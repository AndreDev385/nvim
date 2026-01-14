return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			require("dapui").setup()
			require("dap-go").setup()
			require("nvim-dap-virtual-text").setup()

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

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			-- C/C++/Rust
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}

			dap.configurations.rust = {
				{
					name = "Debug with GDB",
					type = "gdb",
					request = "launch",
					program = function()
						-- Automatically detect binary from Cargo.toml
						local cargo_toml = io.open("Cargo.toml", "r")
						if not cargo_toml then
							return
						end

						local name = cargo_toml:read("*a"):match('name%s*=%s*"([^"]+)"')
						cargo_toml:close()

						if name then
							return vim.fn.getcwd() .. "/target/debug/" .. name
						end
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
					args = {},
					environment = {},
					externalConsole = false,
					MIMode = "gdb",
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "Enable pretty-printing",
							ignoreFailures = true,
						},
					},
				},
			}

			dap.configurations.scala = {
				{
					type = "scala",
					request = "launch",
					name = "Run or Test Target",
					metals = {
						runType = "runOrTestFile",
					},
				},
				{
					type = "scala",
					request = "launch",
					name = "Test Target",
					metals = {
						runType = "testTarget",
					},
				},
				{
					type = "scala",
					request = "attach",
					name = "Attach to Localhost",
					hostName = "localhost",
					port = 5005,
					buildTarget = "root",
				},
			}

			dap.configurations.metals = {
				runType = "run",
				args = { "foo", "bar" },
				jvmOptions = { "-Dpropert=123" },
				env = { RETRY = "TRUE" },
				envFile = ".env",
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
		},
	},
}
