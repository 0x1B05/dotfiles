local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>")
-- Terminal mappings
-- map("n", "<C-t>", ":split | term<CR>") -- open

-- move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

map({ "n", "v", "o" }, "H", "^", { desc = "Use 'H' as '^'" })
map({ "n", "v", "o" }, "L", "$", { desc = "Use 'L' as '$'" })
map("i", "jj", "<Esc>")

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- Resize window in neovim using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +5<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -5<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })

-- buffers
map("n", "<S-j>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-k>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-x>", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>h", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>k", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>j", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save file" })

-- keymaps for plugins
local util = require("config.util")
local M = {}
M.telescope = {
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "TL file" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "TL grep" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "TL buffer" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "TL tags" },
}
M.nvim_tree = {
	{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
}
M.spectre = { {
	"<leader>sr",
	function()
		require("spectre").open()
	end,
}, desc = "Spectre" }
M.lsp = {
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "show the declaration" },
	{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to definition" },
	-- {"K", "<cmd>lua vim.lsp.buf.hover()<CR>", },
	{ "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "go to implementation" },
	{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "go to references" },
	{ "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "diagnostic float" },
	{ "<leader>lf", util.format, desc = "Format" },
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "LspInfo" },
	{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "LspInstallInfo" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "code action" },
	{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc = "go to next diagnostic" },
	{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "go to prev diagnostic" },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "rename buffer" },
	{ "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "signature help" },
	{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "set loclist" },
}
M.persistence = {
	{
		"<leader>Ss",
		function()
			require("persistence").save()
		end,
		desc = "Save Session",
	},
	{
		"<leader>Sl",
		function()
			require("persistence").load()
		end,
		desc = "Load Session",
	},
}
M.tmux = {
	map("n", "<S-Up>", "<cmd>lua require('tmux').resize_top()<cr>", { desc = "Increase window height" }),
	map("n", "<S-Down>", "<cmd>lua require('tmux').resize_bottom()<cr>", { desc = "Decrease window height" }),
	map("n", "<S-Left>", "<cmd>lua require('tmux').resize_left()<cr>", { desc = "Decrease window width" }),
	map("n", "<S-Right>", "<cmd>lua require('tmux').resize_right()<cr>", { desc = "Increase window width" }),
	map("n", "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", { desc = "Move to the left tmux and nvim window" }),
	map(
		"n",
		"<C-j>",
		"<cmd>lua require('tmux').move_bottom()<cr>",
		{ desc = "Move to the bottom tmux and nvim window" }
	),
	map("n", "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", { desc = "Move to the top tmux and nvim window" }),
	map("n", "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", { desc = "Move to the right tmux and nvim window" }),
}
M.toggleterm = {
	{ "t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Move to the left window in terminal mode." } },
	{ "t", "<C-j>", "<C-\\><C-N><C-w>j", { desc = "Move to the below window in terminal mode." } },
	{ "t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Move to the above window in terminal mode." } },
	{ "t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Move to the right window in terminal mode." } },
}
return M
