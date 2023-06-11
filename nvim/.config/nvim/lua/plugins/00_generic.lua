local keymaps = require("config.keymaps")

return {
	{ "folke/lazy.nvim", version = "*" },
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle" },
		keys = keymaps.nvim_tree,
		opts = {
			respect_buf_cwd = true,
			view = {
				width = 40,
				number = true,
				relativenumber = true,
			},
			root_dirs = { "~" },
			filters = {
				custom = { ".git", ".aux"  },
				dotfiles = false,
			},
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
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
		tag = "0.1.1",
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
	-- Git labels
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("gitsigns").setup({})
		end,
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
	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
}
