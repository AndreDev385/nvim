local opt = vim.opt

vim.g.autoformat = false
opt.inccommand = "split"
opt.guicursor = ""

opt.smartcase = true
opt.ignorecase = true
opt.wrap = false
opt.vb = true

opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"

-- current line number
opt.nu = true
opt.rnu = true

-- indentation
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = false

opt.scrolloff = 2
opt.smartindent = true

-- folds
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"
vim.wo.foldnestmax = 1
vim.wo.foldminlines = 1
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g')]]
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.wildmode = "list:longest"
opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"

-- hightlight coincidences on search
opt.hlsearch = true
opt.incsearch = true

-- background color scheme
opt.termguicolors = true
opt.background = "dark"

opt.colorcolumn = "80"
opt.listchars = "tab:> ,nbsp:¬,extends:»,precedes:«,trail:•"
opt.cursorline = true

vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })

opt.isfname:append("@-@")
opt.updatetime = 50
opt.splitright = true
opt.splitbelow = true

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
