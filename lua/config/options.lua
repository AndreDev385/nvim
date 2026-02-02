vim.g.mapleader = " "
vim.o.number = true
vim.o.numberwidth = 1
vim.o.signcolumn = "yes"
vim.opt.smartindent = true
vim.o.wrap = true
vim.opt.wrap = true
vim.wo.relativenumber = true

-- folds
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldenable = true
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldnestmax = 4
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g')]]

-- search
vim.opt.hls = false
vim.opt.incsearch = true

-- undo dir
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- indentation
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.scrolloff = 4

vim.opt.updatetime = 50
vim.opt.autoread = true

vim.opt.wildmode = "list:longest"
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"

vim.opt.listchars = "tab:> ,nbsp:¬,extends:»,precedes:«,trail:•"

-- spelling
vim.opt.spelllang = "en_us,es"
vim.opt.spell = true

vim.filetype.add({
	extension = {
		["http"] = "http",
		templ = "templ",
	},
})

vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime"
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained" }, {
	pattern = "*",
	command = "checktime"
})
