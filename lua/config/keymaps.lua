local set = vim.keymap.set
local options = { noremap = true, silent = true }
--local k = vim.keycode

local del = vim.keymap.del
del({ "n", "x" }, "gra")
del("n", "gri")
del("n", "grr")
del("n", "grn")

set("i", "<C-c>", "<Esc>")
-- navigate between windows
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<leader><CR>", "<cmd>source %<CR>", { desc = "Execute the current file", options.unpack })

-- Move highlighting text
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)

-- quick fix list
set("n", "<leader>qj", "<cmd>cnext<CR>")
set("n", "<leader>qk", "<cmd>cprev<CR>")
set("n", "<leader>qo", "<cmd>copen<CR>")
set("n", "<leader>qc", "<cmd>cclose<CR>")

set("n", "<leader>gs", vim.cmd.Git)
set("n", "<leader>gvd", vim.cmd.Gvdiffsplit)
set("n", "<leader>f", vim.lsp.buf.format)
set("n", "<leader>w", "<cmd>:w<CR>")

set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/init.lua<CR>")
set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-------------------------------------------------------------------------------
--                           Folding section
-------------------------------------------------------------------------------

-- Checks each line to see if it matches a markdown heading (#, ##, etc.):
-- It’s called implicitly by Neovim’s folding engine by vim.opt_local.foldexpr
function _G.markdown_foldexpr()
	local lnum = vim.v.lnum
	local line = vim.fn.getline(lnum)
	local heading = line:match("^(#+)%s")
	if heading then
		local level = #heading
		if level == 1 then
			-- Special handling for H1
			if lnum == 1 then
				return ">1"
			else
				local frontmatter_end = vim.b.frontmatter_end
				if frontmatter_end and (lnum == frontmatter_end + 1) then
					return ">1"
				end
			end
		elseif level >= 2 and level <= 6 then
			-- Regular handling for H2-H6
			return ">" .. level
		end
	end
	return "="
end

local function set_markdown_folding()
	vim.opt_local.foldmethod = "expr"
	vim.opt_local.foldexpr = "v:lua.markdown_foldexpr()"
	vim.opt_local.foldlevel = 99

	-- Detect frontmatter closing line
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local found_first = false
	local frontmatter_end = nil
	for i, line in ipairs(lines) do
		if line == "---" then
			if not found_first then
				found_first = true
			else
				frontmatter_end = i
				break
			end
		end
	end
	vim.b.frontmatter_end = frontmatter_end
end

-- Use autocommand to apply only to markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = set_markdown_folding,
})

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
	-- Move to the top of the file without adding to jumplist
	vim.cmd("keepjumps normal! gg")
	-- Get the total number of lines
	local total_lines = vim.fn.line("$")
	for line = 1, total_lines do
		-- Get the content of the current line
		local line_content = vim.fn.getline(line)
		-- "^" -> Ensures the match is at the start of the line
		-- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
		-- "%s" -> Matches any whitespace character after the "#" characters
		-- So this will match `## `, `### `, `#### ` for example, which are markdown headings
		if line_content:match("^" .. string.rep("#", level) .. "%s") then
			-- Move the cursor to the current line without adding to jumplist
			vim.cmd(string.format("keepjumps call cursor(%d, 1)", line))
			-- Check if the current line has a fold level > 0
			local current_foldlevel = vim.fn.foldlevel(line)
			if current_foldlevel > 0 then
				-- Fold the heading if it matches the level
				if vim.fn.foldclosed(line) == -1 then
					vim.cmd("normal! za")
				end
				-- else
				--   vim.notify("No fold at line " .. line, vim.log.levels.WARN)
			end
		end
	end
end

local function fold_markdown_headings(levels)
	-- I save the view to know where to jump back after folding
	local saved_view = vim.fn.winsaveview()
	for _, level in ipairs(levels) do
		fold_headings_of_level(level)
	end
	vim.cmd("nohlsearch")
	-- Restore the view to jump to where I was
	vim.fn.winrestview(saved_view)
end

vim.keymap.set("n", "zj", function()
	-- "Update" saves only if the buffer has been modified since the last save
	vim.cmd("silent update")
	-- vim.keymap.set("n", "<leader>mfj", function()
	-- Reloads the file to refresh folds, otheriise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
	vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 1 or above" })

vim.keymap.set("n", "zk", function()
	-- "Update" saves only if the buffer has been modified since the last save
	vim.cmd("silent update")
	-- vim.keymap.set("n", "<leader>mfk", function()
	-- Reloads the file to refresh folds, otherwise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3, 2 })
	vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 2 or above" })

vim.keymap.set("n", "zl", function()
	-- "Update" saves only if the buffer has been modified since the last save
	vim.cmd("silent update")
	-- vim.keymap.set("n", "<leader>mfl", function()
	-- Reloads the file to refresh folds, otherwise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4, 3 })
	vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 3 or above" })

vim.keymap.set("n", "z;", function()
	-- "Update" saves only if the buffer has been modified since the last save
	vim.cmd("silent update")
	-- vim.keymap.set("n", "<leader>mf;", function()
	-- Reloads the file to refresh folds, otherwise you have to re-open neovim
	vim.cmd("edit!")
	-- Unfold everything first or I had issues
	vim.cmd("normal! zR")
	fold_markdown_headings({ 6, 5, 4 })
	vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 4 or above" })

vim.keymap.set("n", "zu", function()
	-- "Update" saves only if the buffer has been modified since the last save
	vim.cmd("silent update")
	-- vim.keymap.set("n", "<leader>mfu", function()
	-- Reloads the file to reflect the changes
	vim.cmd("edit!")
	vim.cmd("normal! zR") -- Unfold all headings
	vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Unfold all headings level 2 or above" })

vim.keymap.set("n", "zi", function()
	-- "Update" saves only if the buffer has been modified since the last save
	vim.cmd("silent update")
	-- Difference between normal and normal!
	-- - `normal` executes the command and respects any mappings that might be defined.
	-- - `normal!` executes the command in a "raw" mode, ignoring any mappings.
	vim.cmd("normal gk")
	-- This is to fold the line under the cursor
	vim.cmd("normal! za")
	vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold the heading cursor currently on" })

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------
