return {
	"rest-nvim/rest.nvim",
	dependencies = { "luarocks.nvim" },
	config = function()
		require("rest-nvim").setup({
			response = {
				hooks = {
					decode_url = false
				}
			},
			env = {
				pattern = "%.env$"
			},
			ui = {
				keybinds = {
					prev = "P",
					next = "N",
				},
			},
			highlight = {
				enable = true,
			}
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "json",
			callback = function(ev)
				vim.bo[ev.buf].formatprg = "jq"
				print("It's a json file")
			end,
		})

		vim.bo.formatexpr = "v:lua.require’conform’.formatexpr()"
		require("telescope").load_extension("rest");
	end,
}

