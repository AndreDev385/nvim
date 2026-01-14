---@brief
---
--- https://github.com/withastro/language-tools/tree/main/packages/language-server
---
--- `astro-ls` can be installed via `npm`:
--- ```sh
--- npm install -g @astrojs/language-server
--- ```

return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	init_options = {
		typescript = {
			tsdk = "/home/andre/.volta/tools/image/node/22.15.0/lib/node_modules/typescript/lib"
		},
	},
	settings = {
		astro = {
			typescript = {
				tsdk = "/home/andre/.volta/tools/image/node/22.15.0/lib/node_modules/typescript/lib"
			},
			languageFeatures = {
				codeActions = true,
				completions = true,
				definitions = true,
				diagnostics = true,
				documentHighlights = true,
				documentLinks = true,
				documentSymbols = true,
				hover = true,
				inlayHints = true,
				rename = true,
				signatureHelp = true,
				workspaceSymbol = true,
			},
		},
	},
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	before_init = function(_, config)
		-- Find the project root directory without using lspconfig
		local bufnr = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		
		-- If buffer has no name (unnamed buffer), use current working directory
		if bufname == "" then
			config.root_dir = vim.fn.getcwd()
			return
		end
		
		local bufdir = vim.fn.fnamemodify(bufname, ":p:h")
		local root_dir = nil
		
		-- Search upward for root markers
		for _, marker in ipairs(config.root_markers) do
			local root = vim.fn.findfile(marker, bufdir .. ";")
			if root ~= "" then
				root_dir = vim.fn.fnamemodify(root, ":p:h")
				break
			end
			
			-- Also check for directories (for .git directory)
			root = vim.fn.finddir(marker, bufdir .. ";")
			if root ~= "" then
				root_dir = vim.fn.fnamemodify(root, ":p:h")
				break
			end
		end
		
		-- If no root marker found, use the directory of the file
		if not root_dir then
			root_dir = bufdir
		end
		
		config.root_dir = root_dir
	end,
}
