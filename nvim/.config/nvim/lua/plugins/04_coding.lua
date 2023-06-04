return {
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		-- dependencies = {
		-- 	"rafamadriz/friendly-snippets",
		-- 	config = function()
		-- 		require("luasnip.loaders.from_vscode").lazy_load()
		-- 	end,
		-- },
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
		keys = {
			-- {
			-- 	"fj",
			-- 	function()
			-- 		return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next"
			-- 			or "<c-\\><c-n>:call searchpair('[([{<|]', '', '[)\\]}>|]', 'W')<cr>a"
			-- 	end,
			-- 	expr = true,
			-- 	silent = true,
			-- 	mode = "i",
			-- },
			-- {
			-- 	"fj",
			-- 	function()
			-- 		require("luasnip").jump(1)
			-- 	end,
			-- 	mode = "s",
			-- },
			-- {
			-- 	"fk",
			-- 	function()
			-- 		require("luasnip").jump(-1)
			-- 	end,
			-- 	mode = { "i", "s" },
			-- },
		},
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
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
	-- null-ls as formatter and linter
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local nls = require("null-ls")
			return {
				sources = require("config.options").plugins.nls_sources(nls),
			}
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	--{
	--    "mg979/vim-visual-multi",
	--},
	--{
	--    "tpope/vim-repeat",
	--}
}
