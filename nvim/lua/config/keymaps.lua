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

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save file" })

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

M.yazi1 = {
	{
		"<Leader>e",
		"<cmd>Yazi<cr>",
		desc = "Open yazi at the current file",
	},
	{
		"<leader>E",
		"<cmd>Yazi cwd<cr>",
		desc = "Open the file manager in nvim's working directory",
	},
	{
		"<Leader>o",
		"<cmd>Yazi toggle<cr>",
		desc = "Resume the last yazi session",
	},
}
M.yazi2 = {
	show_help = "<f1>",
	open_file_in_vertical_split = "<c-/>",
	open_file_in_horizontal_split = "<c-->",
	open_file_in_tab = "<c-t>",
	grep_in_directory = "<c-g>",
	replace_in_directory = "<c-r>",
	cycle_open_buffers = "<tab>",
	copy_relative_path_to_selected_files = "<c-y>",
	send_to_quickfix_list = false,
	change_working_directory = "<c-\\>",
}
M.img_clip = {
	{ "<C-A-v>", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
}

M.grug_far = {
	{
		"<leader>sr",
		function()
			local grug = require("grug-far")
			local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
			grug.open({
				transient = true,
				prefills = {
					filesFilter = ext and ext ~= "" and "*." .. ext or nil,
				},
			})
		end,
		mode = { "n", "v" },
		desc = "Search and Replace",
	},
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
	{
		"r",
		mode = "o",
		function()
			require("flash").remote()
		end,
		desc = "Remote Flash",
	},
	{
		"R",
		mode = { "o", "x" },
		function()
			require("flash").treesitter_search()
		end,
		desc = "Treesitter Search",
	},
}

M.lsp = {
	{ "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "hover the variable definition" },
	{ "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "diagnostic float" },
	{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "LspInstallInfo" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "code action" },
	{ "<leader>lf", util.format, desc = "Format" },
	{ "<leader>li", "<cmd>LspInfo<cr>", desc = "LspInfo" },
	{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc = "go to next diagnostic" },
	{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "go to prev diagnostic" },
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
M.snacks = {
	-- ===========================
	-- ToggleTerm 功能
	-- ===========================
	{
		"<leader>tg",
		function()
			Snacks.lazygit()
		end,
		desc = "Lazygit",
	},
	{
		"<leader>tn",
		function()
			Snacks.terminal("ncdu")
		end,
		desc = "Ncdu",
	},
	{
		"<leader>th",
		function()
			Snacks.terminal("htop")
		end,
		desc = "Htop",
	},
	{
		"<c-\\>",
		function()
			Snacks.terminal(nil, { win = { position = "float" } })
		end,
		desc = "Toggle Terminal",
		mode = { "n", "t" },
	},

	{
		"<c-h>",
		function()
			require("tmux").move_left()
		end,
		mode = "t",
		desc = "Go to Left Window",
	},
	{
		"<c-j>",
		function()
			require("tmux").move_bottom()
		end,
		mode = "t",
		desc = "Go to Lower Window",
	},
	{
		"<c-k>",
		function()
			require("tmux").move_top()
		end,
		mode = "t",
		desc = "Go to Upper Window",
	},
	{
		"<c-l>",
		function()
			require("tmux").move_right()
		end,
		mode = "t",
		desc = "Go to Right Window",
	},

	-- ===========================
	-- Telescope 功能 (Picker)
	-- ===========================
	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fg",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<leader>fh",
		function()
			Snacks.picker.help()
		end,
		desc = "Help Pages",
	},
	{
		"<leader>fp",
		function()
			Snacks.picker.projects()
		end,
		desc = "Projects",
	},
	{
		"<leader>fr",
		function()
			Snacks.picker.recent()
		end,
		desc = "Recent",
	},

	-- ===========================
	-- LSP 相关
	-- ===========================
	{
		"gd",
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = "Goto Definition",
	},
	{
		"gD",
		function()
			Snacks.picker.lsp_declarations()
		end,
		desc = "Goto Declaration",
	},
	{
		"gr",
		function()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = "References",
	},
	{
		"gI",
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = "Goto Implementation",
	},
	{
		"gy",
		function()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = "Goto T[y]pe Definition",
	},
	{
		"<leader>ss",
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = "LSP Symbols",
	},
	{
		"<leader>sd",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
	{
		"<leader>sD",
		function()
			Snacks.picker.diagnostics()
		end,
		desc = "Workspace Diagnostics",
	},

	-- ===========================
	-- 其他实用工具
	-- ===========================
	{
		"<leader>n",
		function()
			Snacks.picker.notifications()
		end,
		desc = "Notification History",
	},
	{
		"<leader>z",
		function()
			Snacks.zen()
		end,
		desc = "Toggle Zen Mode",
	},
	{
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		desc = "Delete Buffer",
	},
	{
		"<leader>cR",
		function()
			Snacks.rename.rename_file()
		end,
		desc = "Rename File",
	},
	{
		"<leader>gB",
		function()
			Snacks.gitbrowse()
		end,
		desc = "Git Browse",
		mode = { "n", "v" },
	},
	{
		"<leader>un",
		function()
			Snacks.notifier.hide()
		end,
		desc = "Dismiss All Notifications",
	},
}
return M
