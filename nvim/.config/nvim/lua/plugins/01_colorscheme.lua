return {
	{
		"theniceboy/nvim-deus",
		lazy = true,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme deus]])
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
        opt = {
            theme = "dragon",
        },
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
}
