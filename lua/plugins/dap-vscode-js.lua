return {
	"mxsdev/nvim-dap-vscode-js",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		require("dap-vscode-js").setup({
			--debugger_path = vim.fn.stdpath('data') .. "/mason/vscode-js-debug",
			--debugger_path = "~/.local/share/nvim/vscode-js-debug",
			debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
			adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
		})

		local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

		for _, language in ipairs(js_based_languages) do
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require 'dap.utils'.pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Start Chrome with \"localhost\"",
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
				}
			}
		end
	end
}
