--@brief
--- https://github.com/zigtools/zls
---
--- Zig LSP implementation + Zig Language Server

return {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "zls.json", "build.zig", ".git" },
	workspace_required = false,
	settings = {
		zls = {
			-- Reduce duplicate documentation from ZLS
			enable_inlay_hints = true,
			enable_snippets = true,
			-- These settings can help reduce redundant information in hover
			semantic_tokens = "full",
			-- Don't include build_on_save options to avoid extra documentation
		},
	},
}
