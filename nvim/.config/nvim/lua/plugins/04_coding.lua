return {
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		config = function()
			require("luasnip").config.set_config({
				enable_autosnippets = true,
				store_selection_keys = "`",
			})
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/fvim/LuaSnip" })
		end,
		-- keys = {
		-- 	{
		-- 		"fj",
		-- 		function()
		-- 			return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next"
		-- 				or "<c-\\><c-n>:call searchpair('[([{<|]', '', '[)\\]}>|]', 'W')<cr>a"
		-- 		end,
		-- 		expr = true,
		-- 		silent = true,
		-- 		mode = "i",
		-- 	},
		-- 	{
		-- 		"fj",
		-- 		function()
		-- 			require("luasnip").jump(1)
		-- 		end,
		-- 		mode = "s",
		-- 	},
		-- 	{
		-- 		"fk",
		-- 		function()
		-- 			require("luasnip").jump(-1)
		-- 		end,
		-- 		mode = { "i", "s" },
		-- 	},
		-- },
	},

	-- surround
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
		config = function(_, opts)
			-- use gz mappings instead of s to prevent conflict with leap
			require("mini.surround").setup(opts)
		end,
	},

	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	{
		"numToStr/Comment.nvim",
		lazy = true,
		keys = {
			{ "gcc", mode = "n", desc = "Line-comment toggle keymap" },
			{ "gbc", mode = "n", desc = "Block-comment toggle keymap" },
			{ "gbO", mode = "n", esc = "Add comment on the line above" },
			{ "gbo", mode = "n", esc = "Add comment on the line below" },
			{ "gbA", mode = "n", esc = "Add comment at the end of line" },
		},
		config = function()
			require("Comment").setup({
				---Add a space b/w comment and the line
				padding = true,
				---Whether the cursor should stay at its position
				sticky = true,
				---Lines to be ignored while (un)comment
				ignore = nil,
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					line = "gc",
					block = "gb",
				},
				---LHS of extra mappings
				extra = {
					above = "gcO",
					below = "gco",
					---Add comment at the end of line
					eol = "gcA",
				},
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
				pre_hook = function(ctx)
					local U = require("Comment.utils")

					local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
					if not status_utils_ok then
						return
					end

					local location = nil
					if ctx.ctype == U.ctype.block then
						location = utils.get_cursor_location()
					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						location = utils.get_visual_start_location()
					end

					local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
					if not status_internals_ok then
						return
					end

					return internals.calculate_commentstring({
						key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
						location = location,
					})
				end,
			})
		end,
	},

	-- auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'", "`", "<" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
	},

	-- toggleterm
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			local node = Terminal:new({ cmd = "node", hidden = true })

			function _NODE_TOGGLE()
				node:toggle()
			end

			local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

			function _NCDU_TOGGLE()
				ncdu:toggle()
			end

			local htop = Terminal:new({ cmd = "htop", hidden = true })

			function _HTOP_TOGGLE()
				htop:toggle()
			end

			local python = Terminal:new({ cmd = "python", hidden = true })

			function _PYTHON_TOGGLE()
				python:toggle()
			end
		end,
	},

	--{
	--    "mg979/vim-visual-multi",
	--},
	--{
	--    "tpope/vim-repeat",
	--}
}
