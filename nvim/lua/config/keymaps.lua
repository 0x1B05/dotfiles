local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

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
map("v", "p", "P")

-- windows
map("n", "<leader>wj", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>wl", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>wq", "<C-W>q", { desc = "Quit the current window" })
map("n", "<leader>wx", "<C-W>x", { desc = "Swap the current window with the next window" })

-- Resize window in neovim using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +5<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -5<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })

-- buffers
map("n", "<leader>j", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>k", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-x>", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>h", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>k", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>j", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- terminal
map("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", { desc = "Open lazygit terminal" })
map("n", "<leader>tn", "<cmd>lua _NCDU_TOGGLE()<cr>", { desc = "Open ncdu terminal" })
map("n", "<leader>th", "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "Open htop terminal" })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save file" })

-- paste image
map({ "i" }, "<C-A-v>", "<cmd>Pastify<cr>", { desc = "Save file" })

-- preview typst
map("n", "<leader>pt", "<cmd>TypstWatch<cr>", { desc = "Typst preview" })

-- compile java
map("n", "<leader>pj", "<cmd>make PACKAGE=%:p:h:t %:t:r<cr>", { desc = "Java single-file compile." })

-- refresh snippets
map(
	"n",
	"<leader>U",
	"<Cmd>lua require('luasnip.loaders.from_lua').load({paths = '~/dotfiles/nvim/lua/plugins/luasnip'})<CR><Cmd>echo 'Snippets reloaded.'<CR>",
	{ desc = "Hot reload snippets." }
)

-- keymaps for plugins
local util = require("config.util")
local M = {}
M.telescope = {
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope find buffer" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find file" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope grep" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope find help tags" },
}

M.yazi = {
	show_help = "<f1>",
	open_file_in_vertical_split = "<c-/>",
	open_file_in_horizontal_split = "<c-->",
	open_file_in_tab = "<cr>",
	grep_in_directory = "<c-s>",
	replace_in_directory = "<c-g>",
	cycle_open_buffers = "<tab>",
	copy_relative_path_to_selected_files = "<c-y>",
	send_to_quickfix_list = "<c-q>",
	change_working_directory = "<c-\\>",
}

M.spectre = {
	{
		"<leader>sr",
		function()
			require("spectre").open()
		end,
	},
	desc = "Spectre",
}
M.leap = {
	{
		" ",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	},
	{
		",",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump({
				search = { mode = "search", max_length = 0 },
				label = { after = { 0, 0 } },
				pattern = "^",
			})
		end,
		desc = "Flash line",
	},
	{
		"{",
		mode = { "n", "o", "x" },
		function()
			require("flash").treesitter()
		end,
		desc = "Flash Treesitter",
	},
}

M.lsp = {
	{ "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "hover the variable definition" },
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "show the declaration" },
	{ "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "go to implementation" },
	{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to definition" },
	{ "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "diagnostic float" },
	{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "go to references" },
	{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "LspInstallInfo" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "code action" },
	{ "<leader>lf", util.format, desc = "Format" },
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "LspInfo" },
	{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc = "go to next diagnostic" },
	{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "go to prev diagnostic" },
	{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "set loclist" },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "rename buffer" },
	{ "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "signature help" },
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
M.knap = {
	{
		"<leader>pk",
		function()
			require("knap").toggle_autopreviewing()
		end,
		desc = "Knap toggle auto previewing",
	},
	{
		"<leader>ps",
		function()
			require("knap").forward_jump()
		end,
		desc = "Knap forward jump",
	},
	{
		"<leader>pr",
		function()
			require("knap").process_once()
		end,
		desc = "Knap processes the document and refreshes the view",
	},
	{
		"<leader>pc",
		function()
			require("knap").close_viewer()
		end,
		desc = "Knap closes the viewer application",
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
M.comment = {
	{ "gcc", mode = "n", desc = "Line-comment toggle keymap" },
	{ "gbc", mode = "n", desc = "Block-comment toggle keymap" },
	{ "gbO", mode = "n", esc = "Add comment on the line above" },
	{ "gbo", mode = "n", esc = "Add comment on the line below" },
	{ "gbA", mode = "n", esc = "Add comment at the end of line" },
	{ "gc", mode = "v", esc = "Line-comment toggle keymap in visual mode" },
	{ "gb", mode = "v", esc = "Line-comment toggle keymap in visual mode" },
}
return M
