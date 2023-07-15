local util = require("config.util")
local servers = require("config.options").plugins.lsp_servers
local handlers = require("plugins.lspconfig.handlers")

return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "show the declaration" },
			{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to definition" },
			-- {"K", "<cmd>lua vim.lsp.buf.hover()<CR>", },
			{ "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "go to implementation" },
			{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "go to references" },
			{ "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "diagnostic float" },
			{ "<leader>lf", util.format, desc = "Format" },
			{ "<leader>li", "<cmd>LspInfo<cr>", desc = "LspInfo" },
			{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "LspInstallInfo" },
			{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "code action" },
			{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", desc = "go to next diagnostic" },
			{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "go to prev diagnostic" },
			{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "rename buffer" },
			{ "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "signature help" },
			{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "set loclist" },
		},
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
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
			},
		},

		config = function()
			handlers.setup()
			local lspconfig = require("lspconfig")
			for _, server in pairs(servers) do
				local opts = {
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
