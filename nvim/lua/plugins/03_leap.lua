local keymaps = require("config.keymaps")
return {
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

	--{
	--    "mg979/vim-visual-multi",
	--}
}
