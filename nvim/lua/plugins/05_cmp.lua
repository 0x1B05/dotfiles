return {
	-- auto completion
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept" },
				["<CR>"] = { "accept", "fallback" }, -- 如果没选中，回车就换行

				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<M-n>"] = { "snippet_forward", "fallback" },
				["<M-p>"] = { "snippet_backward", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",

				kind_icons = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			},

			signature = { enabled = true },

			cmdline = {
				enabled = true,
				keymap = {
					preset = "none",
					["<Tab>"] = { "show", "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<C-n>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback" },
					["<CR>"] = { "accept_and_enter", "fallback" },
					["<C-e>"] = { "hide" },
				},
				sources = function()
					local type = vim.fn.getcmdtype()
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					if type == ":" then
						return { "cmdline", "path" }
					end
					return {}
				end,
				completion = {
					menu = { auto_show = true },
					ghost_text = { enabled = true },
					list = {
						selection = {
							preselect = false, -- 不自动选中第一项
							auto_insert = true, -- 选择时才插入文本
						},
					},
				},
			},

			snippets = {
				preset = "luasnip",
				expand = function(snippet)
					require("luasnip").lsp_expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require("luasnip").jumpable(filter.direction)
					end
					return require("luasnip").in_snippet()
				end,
				jump = function(direction)
					require("luasnip").jump(direction)
				end,
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						-- 可以在这里配置 LSP 相关的过滤
					},
				},
			},

			completion = {
				menu = { border = "single" },
				documentation = { window = { border = "single" }, auto_show = true, auto_show_delay_ms = 200 },
				list = { selection = { preselect = true, auto_insert = false } },
			},
		},
		opts_extend = { "sources.default" },
		-- config = function(_, opts)
		-- 	local blink = require("blink.cmp")
		-- 	local ls = require("luasnip")
		--
		-- 	blink.setup(opts)
		--
		-- 	-- 定义 jk：覆盖 Insert 和 Select 模式
		-- 	vim.keymap.set({ "i", "s" }, "jk", function()
		-- 		-- 优先：Snippet 跳转
		-- 		if ls.jumpable(1) then
		-- 			ls.jump(1)
		-- 		-- 其次：补全菜单选择下一项
		-- 		elseif blink.is_visible() then
		-- 			blink.select_next()
		-- 		-- 最后：原样输入 jk
		-- 		else
		-- 			-- 使用 feedkeys 模拟按键，确保能触发其他可能存在的映射或直接上屏
		-- 			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("jk", true, false, true), "n", false)
		-- 		end
		-- 	end, { silent = true })
		--
		-- 	-- 定义 kj：覆盖 Insert 和 Select 模式
		-- 	vim.keymap.set({ "i", "s" }, "kj", function()
		-- 		if ls.jumpable(-1) then
		-- 			ls.jump(-1)
		-- 		elseif blink.is_visible() then
		-- 			blink.select_prev()
		-- 		else
		-- 			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("kj", true, false, true), "n", false)
		-- 		end
		-- 	end, { silent = true })
		-- end,
	},
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
}
