local opt = vim.opt

vim.g.autoformat = false
opt.inccommand = "split"
opt.guicursor = ""

opt.smartcase = true
opt.ignorecase = true

opt.wrap = false
opt.number = true
opt.relativenumber = true

opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.nu = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.scrolloff = 4
opt.smartindent = true
opt.wrap = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.isfname:append("@-@")
opt.updatetime = 50
opt.splitright = true

opt.foldmethod = "indent"
opt.spelllang = "en_us,es"
opt.spell = true

vim.filetype.add({ extension = { templ = "templ" } })
vim.cmd([[
    set notimeout
    set encoding=UTF-8
    set conceallevel=2
]])
