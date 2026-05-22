vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.winborder = "rounded"
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.cursorcolumn = false
vim.opt.smartindent = true
vim.opt.incsearch = true --highlights when pattern matching
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cole = 2

vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldenable = true
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldnestmax = 4
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g')]]

local map = vim.keymap.set

map("n", "<leader><leader>", ":so<CR>")
map("n", "<leader>w", ":write<CR>")
map("n", "<leader>q", ":quit<CR>")
map("n", "<leader>lf", function()
	require("conform").format()
end)

-- quick fix list
map("n", "<leader>qj", "<cmd>cnext<CR>")
map("n", "<leader>qk", "<cmd>cprev<CR>")
map("n", "<leader>qo", "<cmd>copen<CR>")
map("n", "<leader>qc", "<cmd>cclose<CR>")

-- Move highlighting text
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

require("harpoon").setup()
require("oil").setup()
require("mason").setup()
require("mini.pick").setup()
require("nvim-treesitter").setup({
	ensure_installed = {
		"dart",
		"react",
		"typescript",
		"svelte",
		"astro",
		"go",
		"zig",
		"css",
		"html",
		"odin",
		"python",
		"markdown",
		"markdown_inline",
	},
	highlight = { enable = true },
	indent = { enable = true },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "odin",
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "svelte",
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "org",
	callback = function()
		vim.treesitter.start()
	end,
})

require("wlsample.airline")

vim.lsp.enable({
	"astro",
	"cssls",
	"dartls",
	"gopls",
	"html",
	"lua_ls",
	"tailwindcss",
	"ts_ls",
	"astro",
	"svelte",
	"zls",
	"emmet_ls",
	"biome",
	"org",
	"ols",
	"pyright",
	"ruff",
	"marksman",
})

vim.g.tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"

require("vague").setup()
vim.cmd("colorscheme vague")

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
require("nvim-autopairs").setup()

cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,noselect",
		keyword_length = 1,
	},
	sources = {
		{ name = "nvim_lsp", priority = 1000 },
		{ name = "luasnip", priority = 750 },
		{ name = "path", priority = 500 },
		{ name = "buffer", priority = 250 },
		{ name = "emoji", priority = 0 },
		{ name = "orgmode" },
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Insert,
		}),
		["<C-j>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	performance = {
		max_view_entries = 50,
		debounce = 60,
		throttle = 30,
	},
})

local cmdline_mapping = {
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-e>"] = cmp.mapping.abort(),
	["<C-n>"] = {
		c = function()
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.complete()
			end
		end,
	},
	["<C-p>"] = {
		c = function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end,
	},
}

-- Command line completions with enhanced styling
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmdline_mapping,
	sources = {
		{ name = "buffer" },
	},
	window = {
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			border = "rounded",
		}),
	},
})

cmp.setup.cmdline(":", {
	mapping = cmdline_mapping,
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	window = {
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
			border = "rounded",
		}),
	},
})

-- Enable autopairs integration
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Git
require("gitsigns").setup({
	numhl = true,
	signs = {
		add = { text = "+" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	attach_to_untracked = true,
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "stage hunk" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "reset hunk" })
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "stage hunk" })
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "reset_hunk" })
		map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "stage buffer" })
		map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "reset buffer" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview hunk" })
		map("n", "<leader>hB", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "blame line" })
		map("n", "<leader>hb", gitsigns.toggle_current_line_blame, { desc = "toggle current line blame" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "diff this" })
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end, { desc = "diff this" })
		map("n", "<leader>htd", gitsigns.preview_hunk_inline)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

map("n", "<space>gs", vim.cmd.Git)

local harpoon = require("harpoon")

harpoon:setup()

map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<leader>a", function()
	harpoon:list():add()
end)

map("n", "<leader>1", function()
	harpoon:list():select(1)
end)

map("n", "<leader>2", function()
	harpoon:list():select(2)
end)

map("n", "<leader>3", function()
	harpoon:list():select(3)
end)

map("n", "<leader>4", function()
	harpoon:list():select(4)
end)

map("n", "<leader>u", vim.cmd.UndotreeToggle)

--disabled nvim surround
vim.g.surround_no_mappings = 1
vim.opt.virtualedit = "block"
