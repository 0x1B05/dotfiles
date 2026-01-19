local util = require("config.util")
local keymaps = require("config.keymaps")

return {
	-- manage LSP servers, DAP servers, linters, and formatters
	{

		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = require("config.options").ensure_installed.mason_tools,
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	-- easy lspconfig: implicitly load mason and auto install lsp servers
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		keys = keymaps.lsp,
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		opts = {
			servers = {
				clangd = {},
				lua_ls = {},
				tinymist = {},
				cmake = {},
			},
		},
		config = function(_, opts)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local function on_attach(client, bufnr)
				-- 加载 config/keymaps.lua 中定义的 M.lsp 键位
				if keymaps.lsp then
					for _, key in ipairs(keymaps.lsp) do
						local mode = key.mode or "n"
						local lhs = key[1]
						local rhs = key[2]
						local key_opts = { desc = key.desc, buffer = bufnr }
						vim.keymap.set(mode, lhs, rhs, key_opts)
					end
				end
			end

			require("mason-lspconfig").setup({
				ensure_installed = require("config.options").ensure_installed.lsp_servers,
				automatic_installation = true,
				automatic_enable = true,
				handlers = {
					function(server_name)
						local server_opts = opts.servers[server_name] or {}
						server_opts.capabilities =
							vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
						server_opts.on_attach = on_attach

						require("lspconfig")[server_name].setup(server_opts)
					end,
				},
			})
		end,
	},

	-- formatter
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
		opts = {
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				scala = { "scalafmt" },
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,
				bash = { "shfmt" },
				sh = { "shfmt" },
				lua = { "stylua" },
				typst = { "typstyle" },
				html = { "prettier" },
				markdown = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
				verilog = { "verible" },
			},
			formatters = {
				clang_format = {
					command = "clang-format",
					-- "--style={BasedOnStyle: Google, IndentWidth: 4, DerivePointerAlignment: true, PointerAlignment: Right, SortIncludes: false}",
					args = {
						"--style={BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 88, AlignAfterOpenBracket: Align, AlignTrailingComments: true, DerivePointerAlignment: true, PointerAlignment: Right, SortIncludes: false}",
					},
					stdin = true,
				},
			},
			log_level = vim.log.levels.WARN,
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePost", "BufReadPost", "InsertLeave" },
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				markdown = { "markdownlint" },
				cpp = { "verilator" },
			},
			---@type table<string,table>
			linters = {
				verilator = {
					args = {
						"--lint-only",
						"-F",
						vim.fs.find("verilator.f", {
							upward = true,
							stop = "/home",
							type = "file",
						})[1],
					},
				},
			},
		},
		config = function(_, opts)
			local M = {}

			local lint = require("lint")
			for name, linter in pairs(opts.linters) do
				if type(linter) == "table" and type(lint.linters[name]) == "table" then
					lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
					if type(linter.prepend_args) == "table" then
						lint.linters[name].args = lint.linters[name].args or {}
						vim.list_extend(lint.linters[name].args, linter.prepend_args)
					end
				else
					lint.linters[name] = linter
				end
			end
			lint.linters_by_ft = opts.linters_by_ft

			function M.debounce(ms, fn)
				local timer = vim.uv.new_timer()
				return function(...)
					local argv = { ... }
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule_wrap(fn)(unpack(argv))
					end)
				end
			end

			function M.lint()
				-- Use nvim-lint's logic first:
				-- * checks if linters exist for the full filetype first
				-- * otherwise will split filetype by "." and add all those linters
				-- * this differs from conform.nvim which only uses the first filetype that has a formatter
				local names = lint._resolve_linter_by_ft(vim.bo.filetype)

				-- Create a copy of the names table to avoid modifying the original.
				names = vim.list_extend({}, names)

				-- Add fallback linters.
				if #names == 0 then
					vim.list_extend(names, lint.linters_by_ft["_"] or {})
				end

				-- Add global linters.
				vim.list_extend(names, lint.linters_by_ft["*"] or {})

				-- Filter out linters that don't exist or don't match the condition.
				local ctx = { filename = vim.api.nvim_buf_get_name(0) }
				ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
				names = vim.tbl_filter(function(name)
					local linter = lint.linters[name]
					if not linter then
						util.warn("Linter not found: " .. name, { title = "nvim-lint" })
					end
					return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
				end, names)

				-- Run linters.
				if #names > 0 then
					lint.try_lint(names)
				end
			end

			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = M.debounce(100, M.lint),
			})
		end,
	},

	-- cpp
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		config = function() end,
		opts = {
			inlay_hints = {
				inline = false,
			},
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
	},
	-- java, scala
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.init_options.statusBarProvider = "on"
			metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()
			metals_config.on_attach = function(client, bufnr)
				-- your on_attach function
			end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	-- typst
	{ "kaarmu/typst.vim", lazy = true, ft = "typst" },
	-- latex
	{
		"frabjous/knap",
		enabled = true,
		keys = keymaps.knap,
		ft = { "tex", "markdown" },
	},
}
