local set = vim.keymap.set
local options = { noremap = true, silent = true }
--local k = vim.keycode

set("i", "<C-c>", "<Esc>")
-- navigate between windows
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)

set("n", "<leader>gs", vim.cmd.Git)
set("n", "<leader>gvd", vim.cmd.Gvdiffsplit)
set("n", "<leader>f", vim.lsp.buf.format)

set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/init.lua<CR>")
set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Rest Client
set("n", "<leader>xr", ":call VrcQuery()<CR>")
set("n", "<leader>rx", "<cmd>Rest run<CR>")

--Obsidian
vim.keymap.set("n", "<leader>oo",
	":cd /home/andre/obsidian<cr>")

vim.keymap.set("n", "<leader>Ot", ":ObsidianToday<cr>")
vim.keymap.set("n", "<leader>OT", ":ObsidianTomorrow<cr>")
vim.keymap.set("n", "<leader>ot", ":ObsidianTags<cr>")
--
vim.keymap.set("n", "<leader>ot", ":ObsidianTags<cr>")
--
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")
-- strip date from note title and replace dashes with spaces
-- must have cursor on title
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")
--
-- search for files in full vault
vim.keymap.set("n", "<leader>os",
	":Telescope find_files search_dirs={\"/home/andre/obsidian/inbox/\"}<cr>")
vim.keymap.set("n", "<leader>oz",
	":Telescope live_grep search_dirs={\"/home/andre/obsidian/inbox\"}<cr>")
-- delete file in current buffer
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
