local keymaps = require("config.keymaps")

return {
	{ "folke/lazy.nvim", version = "*" },
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle" },
		keys = keymaps.nvim_tree,
		opts = {
			view = {
				width = 40,
				number = true,
				relativenumber = true,
			},
			filters = {
				git_ignored = false,
				dotfiles = false,
				custom = { ".git", ".aux" },
				exclude = { ".json" },
			},
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			-- root_dirs = { "~" },
			update_focused_file = {
				enable = false,
				update_root = false,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		},
	},
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- search/replace in multiple files
	{
		"windwp/nvim-spectre",
		lazy = true,
		keys = keymaps.spectre,
	},
	-- session management
	{
		"folke/persistence.nvim",
		lazy = true,
		keys = keymaps.persistence,
		opts = {
			options = { "buffers", "curdir", "tabpages", "winsize", "help" },
			pre_save = nil,
		},
		config = function(_, opts)
			-- setup config only, no auto save
			require("persistence.config").setup(opts)
		end,
	},
	-- hint with which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			local keymap = {
				-- TODO:
				mode = { "n", "v" },
				["<leader>u"] = { name = "+toggle" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>f"] = { name = "+find" },
				["<leader>g"] = { name = "+go to" },
			}
			wk.register(keymap)
		end,
		opts = {
			key_labels = {
				["<leader>"] = "COLON",
				["<tab>"] = "TAB",
			},
		},
	},
	{
		"aserowy/tmux.nvim",
		event = "VeryLazy",
		config = function()
			require("tmux").setup({
				sync_clipboard = false,
				sync_unnamed = false,
				keys = keymaps.tmux,
				resize = { -- enables default keybindings (A-hjkl) for normal mode
					enable_default_keybindings = false,
					-- sets resize steps for x axis
					resize_step_x = 5,
					-- sets resize steps for y axis
					resize_step_y = 5,
				},
			})
		end,
	},
	-- project manager
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		opts = {
			---@usage set to false to disable project.nvim.
			--- This is on by default since it's currently the expected behavior.
			active = true,
			on_config_done = nil,
			---@usage set to true to disable setting the current-woriking directory
			--- Manual mode doesn't automatically change your root directory, so you have
			--- the option to manually do so using `:ProjectRoot` command.
			manual_mode = false,
			---@usage Methods of detecting the root directory
			--- Allowed values: **"lsp"** uses the native neovim lsp
			--- **"pattern"** uses vim-rooter like glob pattern matching. Here
			--- order matters: if one is not detected, the other is used as fallback. You
			--- can also delete or rearangne the detection methods.
			-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
			detection_methods = { "lsp", "pattern" },
			---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
			patterns = { ".git", "CMakeLists.txt", ".svn", "Makefile", "package.json", "compile_command.json" },
			---@ Show hidden files in telescope when searching for files in a project
			show_hidden = false,
			---@usage When set to false, you will get a message when project.nvim changes your directory.
			-- When set to false, you will get a message when project.nvim changes your directory.
			silent_chdir = false,
			---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
			ignore_lsp = {},
			---@type string
			---@usage path to store the project history for use in telescope
			datapath = vim.fn.stdpath("data"),
		},
		config = function()
			require("telescope").load_extension("projects")
		end,
	},
}
