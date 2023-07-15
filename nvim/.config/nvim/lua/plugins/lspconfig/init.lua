local util = require("config.util")
local servers = require("config.options").plugins.lsp_servers
local handlers = require("plugins.lspconfig.handlers")

return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- load for lsp server setup
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			{
				"hrsh7th/cmp-nvim-lsp",
				config = function()
					return util.has("nvim-cmp")
				end,
			},
		},

		config = function()
			handlers.setup()
			local lspconfig = require("lspconfig")
			for _, server in pairs(servers) do
				opts = {
					on_attach = handlers.on_attach,
					capabilities = handlers.capabilities,
				}

				server = vim.split(server, "@")[1]

				local require_ok, conf_opts = pcall(require, "plugins.lspconfig.langs." .. server)
				if require_ok then
					opts = vim.tbl_deep_extend("force", conf_opts, opts)
				end

				lspconfig[server].setup(opts)
			end
		end,
	},
	-- manage LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = { -- required for :Mason
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
			ui = {
				-- disable check on :Mason window
				check_outdated_packages_on_open = false,
				border = "rounded",
				width = 0.8,
				height = 0.8,
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
			},
		},
	},
	-- easy lspconfig: implicitly load mason and auto install lsp servers
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		opts = {
			ensure_installed = require("config.options").plugins.lsp_servers,
			automatic_installation = false,
		},
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
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
}
