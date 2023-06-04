local keymaps = require("config.keymaps")
return {
	{
		"ggandor/leap.nvim",
		lazy = true,
		event = "BufReadPost",
		config = function()
			require("leap").opts.highlight_unlabeled_phase_one_targets = true
			vim.keymap.set({ "x", "o", "n" }, ",", "<Plug>(leap-forward-to)")
			vim.keymap.set({ "x", "o", "n" }, "<space>b", "<Plug>(leap-backward-to)")
		end,
	},
	{
		"ggandor/flit.nvim",
		lazy = true,
		event = "BufReadPost",
		dependencies = { "ggandor/leap.nvim" },
		config = function()
			require("flit").setup({
				keys = keymaps.flit,
				labeled_modes = "v",
				multiline = true,
				opts = {},
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		lazy = true,
		event = "BufReadPost",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "<space>c", ":HopChar1<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "<space>l", ":HopLine<cr>", { silent = true })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		keys = keymaps.telescope,
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	--{
	--    "mg979/vim-visual-multi",
	--}
}
