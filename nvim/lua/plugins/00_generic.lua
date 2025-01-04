local keymaps = require("config.keymaps")

return {
	{ "folke/lazy.nvim", version = "*" },
	-- file explorer
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	cmd = { "NvimTreeToggle" },
	-- 	keys = keymaps.nvim_tree,
	-- 	opts = {
	-- 		view = {
	-- 			width = 40,
	-- 			number = true,
	-- 			relativenumber = true,
	-- 		},
	-- 		filters = {
	-- 			git_ignored = false,
	-- 			dotfiles = false,
	-- 			custom = { ".git", ".aux" },
	-- 			exclude = { "compile_commands.json" },
	-- 		},
	-- 		sync_root_with_cwd = true,
	-- 		respect_buf_cwd = true,
	-- 		update_focused_file = {
	-- 			enable = false,
	-- 			update_root = false,
	-- 		},
	-- 		actions = {
	-- 			open_file = {
	-- 				quit_on_open = true,
	-- 			},
	-- 		},
	-- 	},
	-- },
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = keymaps.yazi1,
		---@type YaziConfig
		opts = {
			-- Below is the default configuration. It is optional to set these values.
			-- You can customize the configuration for each yazi call by passing it to
			-- yazi() explicitly

			-- enable this if you want to open yazi instead of netrw.
			-- Note that if you enable this, you need to call yazi.setup() to
			-- initialize the plugin. lazy.nvim does this for you in certain cases.
			--
			-- If you are also using neotree, you may prefer not to bring it up when
			-- opening a directory:
			-- {
			--   "nvim-neo-tree/neo-tree.nvim",
			--   opts = {
			--     filesystem = {
			--       hijack_netrw_behavior = "disabled",
			--     },
			--   },
			-- }
			open_for_directories = false,

			-- open visible splits as yazi tabs for easy navigation. Requires a yazi
			-- version more recent than 2024-08-11
			-- https://github.com/mikavilpas/yazi.nvim/pull/359
			open_multiple_tabs = true,

			highlight_groups = {
				-- See https://github.com/mikavilpas/yazi.nvim/pull/180
				hovered_buffer = nil,
				-- See https://github.com/mikavilpas/yazi.nvim/pull/351
				hovered_buffer_in_same_directory = nil,
			},

			-- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
			floating_window_scaling_factor = 0.9,

			-- the transparency of the yazi floating window (0-100). See :h winblend
			yazi_floating_window_winblend = 0,

			-- the log level to use. Off by default, but can be used to diagnose
			-- issues. You can find the location of the log file by running
			-- `:checkhealth yazi` in Neovim. Also check out the "reproducing issues"
			-- section below
			log_level = vim.log.levels.OFF,

			-- what Neovim should do a when a file was opened (selected) in yazi.
			-- Defaults to simply opening the file.
			open_file_function = function(chosen_file, config, state)
				require("yazi.openers").open_file(chosen_file)
			end,

			-- customize the keymaps that are active when yazi is open and focused. The
			-- defaults are listed below. Note that the keymaps simply hijack input and
			-- they are never sent to yazi, so only try to map keys that are never
			-- needed by yazi.
			--
			-- Also:
			-- - use e.g. `open_file_in_tab = false` to disable a keymap
			-- - you can customize only some of the keymaps (not all of them)
			-- - you can opt out of all keymaps by setting `keymaps = false`
			keymaps = keymaps.yazi2,

			-- completely override the keymappings for yazi. This function will be
			-- called in the context of the yazi terminal buffer.
			set_keymappings_function = function(yazi_buffer_id, config, context) end,

			-- the type of border to use for the floating window. Can be many values,
			-- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
			-- more information, see :h nvim_open_win
			yazi_floating_window_border = "rounded",

			-- some yazi.nvim commands copy text to the clipboard. This is the register
			-- yazi.nvim should use for copying. Defaults to "*", the system clipboard
			clipboard_register = "*",

			hooks = {
				-- if you want to execute a custom action when yazi has been opened,
				-- you can define it here.
				yazi_opened = function(preselected_path, yazi_buffer_id, config)
					-- you can optionally modify the config for this specific yazi
					-- invocation if you want to customize the behaviour
				end,

				-- when yazi was successfully closed
				yazi_closed_successfully = function(chosen_file, config, state) end,

				-- when yazi opened multiple files. The default is to send them to the
				-- quickfix list, but if you want to change that, you can define it here
				yazi_opened_multiple_files = function(chosen_files, config, state) end,
			},

			-- highlight buffers in the same directory as the hovered buffer
			highlight_hovered_buffers_in_same_directory = true,

			integrations = {
				--- What should be done when the user wants to grep in a directory
				grep_in_directory = function(directory)
					-- the default implementation uses telescope if available, otherwise nothing
				end,
				grep_in_selected_files = function(selected_files)
					-- similar to grep_in_directory, but for selected files
				end,
				--- Similarly, search and replace in the files in the directory
				replace_in_directory = function(directory)
					-- default: grug-far.nvim
				end,
				replace_in_selected_files = function(selected_files)
					-- default: grug-far.nvim
				end,
				-- `grealpath` on OSX, (GNU) `realpath` otherwise
				resolve_relative_path_application = "",
			},

			future_features = {
				-- Whether to use `ya emit reveal` to reveal files in the file manager.
				-- Requires yazi 0.4.0 or later (from 2024-12-08).
				ya_emit_reveal = true,

				-- Use `ya emit open` as a more robust implementation for opening files
				-- in yazi. This can prevent conflicts with custom keymappings for the enter
				-- key. Requires yazi 0.4.0 or later (from 2024-12-08).
				ya_emit_open = false,
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
		"MagicDuck/grug-far.nvim",
		config = function()
			require("grug-far").setup({
				-- options, see Configuration section below
				-- there are no required options atm
				-- engine = 'ripgrep' is default, but 'astgrep' can be specified
				keymaps = {
					replace = { n = "<localleader>sr" },
					qflist = { n = "<localleader>q" },
					syncLocations = { n = "<localleader>s" },
					syncLine = { n = "<localleader>l" },
					close = { n = "<localleader>c" },
					historyOpen = { n = "<localleader>t" },
					historyAdd = { n = "<localleader>a" },
					refresh = { n = "<localleader>f" },
					openLocation = { n = "<localleader>o" },
					openNextLocation = { n = "<down>" },
					openPrevLocation = { n = "<up>" },
					gotoLocation = { n = "<enter>" },
					pickHistoryEntry = { n = "<enter>" },
					abort = { n = "<localleader>b" },
					help = { n = "g?" },
					toggleShowCommand = { n = "<localleader>p" },
					swapEngine = { n = "<localleader>e" },
					previewLocation = { n = "<localleader>i" },
					swapReplacementInterpreter = { n = "<localleader>x" },
					applyNext = { n = "<localleader>j" },
					applyPrev = { n = "<localleader>k" },
				},
			})
		end,
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
		opts_extend = { "spec" },
		opts = {
			defaults = {},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader><tab>", group = "tabs" },
					{ "<leader>c", group = "code" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
					{ "<leader>s", group = "search" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<leader>b",
						group = "buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<leader>w",
						group = "windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
					-- better descriptions
					{ "gx", desc = "Open with system app" },
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				"<c-w><space>",
				function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
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
	{
		"TobinPalmer/pastify.nvim",
		cmd = { "Pastify" },
		config = function()
			require("pastify").setup({
				opts = {
					absolute_path = false, -- use absolute or relative path to the working directory
					apikey = "", -- Api key, required for online saving
					local_path = "content/images/", -- The path to put local files in, ex ~/Projects/<name>/images/<imgname>.png
					save = "local", -- Either 'local' or 'online'
				},
				ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
					html = '<img src="$IMG$" alt="">',
					markdown = "![]($IMG$)",
					typst = '#figure(caption: [])[#image("$IMG$")]',
					tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
				},
			})
		end,
	},
}
