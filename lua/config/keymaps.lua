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
