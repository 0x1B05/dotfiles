local keymaps = require("config.keymaps")
return {
	-- leap
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {

			modes = {
				char = {
					enabled = true,
					keys = { "f", "F", "t", "T" },
					char_actions = function(motion)
						return {
							[motion:lower()] = "next",
							[motion:upper()] = "prev",
						}
					end,
				},
			},
		},
		keys = keymaps.leap,
	},
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			require("luasnip").config.set_config({
				enable_autosnippets = true,
				store_selection_keys = "<A-p>",
				history = false,
				-- Event on which to check for exiting a snippet's region
				region_check_events = "InsertEnter",
				delete_check_events = "InsertLeave",
				update_events = "TextChanged,TextChangedI",
				ext_opts = {
					[require("luasnip.util.types").choiceNode] = {
						active = {
							virt_text = { { "●", "GruvboxOrange" } },
						},
					},
				},
			})
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/plugins/luasnip" })
			local auto_expand = require("luasnip").expand_auto
			require("luasnip").expand_auto = function(...)
				vim.o.undolevels = vim.o.undolevels
				auto_expand(...)
			end
		end,
	},

	-- surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt" },
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

	--{
	--    "mg979/vim-visual-multi",
	--},
	--{
	--    "tpope/vim-repeat",
	--}
}
