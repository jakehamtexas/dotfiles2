-- The best keymap ever
vim.keymap.set(
	"v",
	"<leader>p",
	'"_dP',
	{ desc = "Delete selected text into _ register and paste before cursor, i.e. replace the selected text" }
)

-- Moving selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves Line Up" })

-- Clipboard
vim.keymap.set({ "v", "n" }, "<leader>mc", '"+y', { desc = "(m)ouse (c)opy" })
vim.keymap.set({ "v", "n" }, "<leader>mp", '"+p', { desc = "(m)ouse (p)aste" })

-- RegExp Magic mode
vim.keymap.set({ "n", "v" }, "/", "/\\v", { desc = "Make search very magic" })
vim.keymap.set("c", "%s/", "%smagic/", { desc = "Make replace very magic" })
vim.keymap.set("c", ">s/", ">smagic/", { desc = "Make replace very magic" })

-- CTRL+d/u niceness
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center the cursor when using CTRL+d" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center the cursor when using CTRL+u" })

local make_middle_scrolloff_keymap = function(key, is_out_of_bounds)
	vim.keymap.set("n", key, function()
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local lines = vim.api.nvim_win_get_height(0)
		local half = math.floor(lines / 2)

		if is_out_of_bounds(row, half) then
			vim.cmd("normal! zz")
		end

		vim.o.scrolloff = half

		-- Dealing with word wrap
		if col == 0 then
			vim.cmd("normal! g" .. key)
		else
			vim.cmd("normal! " .. key)
		end
	end, { noremap = true, silent = true, desc = "Keep the cursor in the middle when scrolling down" })
end

-- Basically "middle scrolloff" all of these things
make_middle_scrolloff_keymap("j", function(row, half)
	return row >= half
end)
make_middle_scrolloff_keymap("k", function(row, half)
	return row < half
end)

vim.keymap.set("n", "n", "nzz", { desc = "Keep the cursor in the middle when searching next" })
vim.keymap.set("n", "N", "Nzz", { desc = "Keep the cursor in the middle when searching previous" })
vim.keymap.set("n", "G", "Gzz", { desc = "Keep the cursor in the middle when going to the bottom of the file" })

-- Buffers
vim.keymap.set("n", "H", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>buffer#<CR>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "delete buffer" })
vim.keymap.set("n", "<leader>bo", function()
	vim.cmd("%bdelete")
	vim.cmd("edit#")
end, { desc = "delete all other buffers" })
vim.keymap.set("n", "<leader>br", function()
	vim.cmd("edit! %")
	vim.notify("Buffer reloaded")
end, { desc = "Reload current buffer" })

-- Diagnostics
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate window up" })

-- LSP
vim.keymap.set("n", "<leader>lr", require("my.lsp.lib").buf_restart_clients, { desc = "(L)sp (R)estart" })
