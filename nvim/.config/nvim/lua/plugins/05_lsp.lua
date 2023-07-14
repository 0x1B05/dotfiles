local util = require("config.util")

return {
    -- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "Goto References" },
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
			{ "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
			{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
			-- { "K", vim.lsp.buf.hover, desc = "Hover" },
			-- { "<C-d>", vim.diagnostic.open_float, desc = "Line Diagnostics" },
			-- { "<C-k>", vim.lsp.buf.signature_help, mode = "", desc = "Signature Help" },
			{ "<C-a>", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "Code Action" },
			{ "<C-f>", util.format, desc = "Format" },
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			-- diagnostic
			vim.diagnostic.config(opts.diagnostics)

			-- setup order: mason -> mason-lspconfig - lsp.server
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local mslp_servers = {}
			if have_mason then
				mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			-- get the cmp capabilities with cmp_nvim_lsp
			local have_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = {}
			if have_cmp then
				capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
			end

			-- define setup handler for mason-lspconfig
			local function s_setup(server)
				local s_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, opts.servers[server] or {})

				require("lspconfig")[server].setup(s_opts)
			end

			-- check to setup manually in case no support from mason
			for server, _ in pairs(opts.servers) do
	               -- stylua: ignore
	               if not vim.tbl_contains(mslp_servers, server) then
	                   s_setup(server)
	               end
			end

			-- check to setup with mason-lspconfig
			if have_mason then
				mlsp.setup_handlers({ s_setup })
			end
		end,
		dependencies = {
			-- load for lsp server setup
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return util.has("nvim-cmp")
				end,
			},
		},
	},
}
