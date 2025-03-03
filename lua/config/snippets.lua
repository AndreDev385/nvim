local ls = require("luasnip")
local types = require("luasnip.util.types")

local M = {}

function M.setup()
	ls.config.set_config({
		history = false,
		updateevents = "TextChanged, TextChangedI",
		enable_autosnippets = true,
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "<- Choice", "Error" } },
				},
			},
		},
	})

	for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
		loadfile(ft_path)()
	end

	-- Keymaps for jumping
	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end, { silent = true })

	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end, { silent = true })
end

return M
