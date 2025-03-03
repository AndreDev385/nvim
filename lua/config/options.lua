local opt = vim.opt

vim.g.autoformat = false
opt.inccommand = "split"
opt.guicursor = ""

opt.smartcase = true
opt.ignorecase = true
opt.wrap = false

opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"

-- current line number
opt.nu = true
opt.rnu = true

-- indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.scrolloff = 8
opt.smartindent = true
opt.wrap = true
-- folds
opt.foldmethod = "indent"

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- hightlight coincidences on search
opt.hlsearch = true
opt.incsearch = true

-- background color scheme
opt.termguicolors = true
opt.background = "dark"

opt.isfname:append("@-@")
opt.updatetime = 50
opt.splitright = true

-- spelling
opt.spelllang = "en_us,es"
opt.spell = true

vim.filetype.add({
	extension = {
		["http"] = "http",
		templ = "templ",
	},
})

vim.cmd([[
    set notimeout
    set encoding=UTF-8
    set conceallevel=2
]])
