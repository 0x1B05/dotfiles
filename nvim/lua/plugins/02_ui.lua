local keymaps = require("config.keymaps")
return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = keymaps.harpoon,
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",

		config = function()
			local lualine = require("lualine")

            -- Color table for highlights
            -- stylua: ignore
            local colors = {
                bg       = '#202328',
                fg       = '#bbc2cf',
                yellow   = '#ECBE7B',
                cyan     = '#008080',
                darkblue = '#081633',
                green    = '#98be65',
                orange   = '#FF8800',
                violet   = '#a9a1e1',
                magenta  = '#c678dd',
                blue     = '#51afef',
                red      = '#ec5f67',
            }

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand("%:p:h")
					local gitdir = vim.fn.finddir(".git", filepath .. ";")
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			local harpoon_component = function()
				local harpoon = require("harpoon")
				local items = harpoon:list().items
				local current_file_path = vim.api.nvim_buf_get_name(0)
				local contents = {}

				for i, item in ipairs(items) do
					local fname = vim.fn.fnamemodify(item.value, ":t")
					if fname == "" then
						fname = "[No Name]"
					end

					local item_path = vim.fn.fnamemodify(item.value, ":p")
					local is_active = (item_path == current_file_path)

					local text = string.format("%d:%s", i, fname)
					if is_active then
						text = "󰛢 " .. text
					end
					table.insert(contents, text)
				end

				if #contents == 0 then
					return ""
				end
				return " " .. table.concat(contents, "  ") .. " "
			end
			-- Config
			local configs = {
				options = {
					-- Disable sections and component separators
					component_separators = "",
					section_separators = "",
					theme = {
						-- We are going to use lualine_c an lualine_x as left and
						-- right section. Both are highlighted by c theme .  So we
						-- are just setting default looks o statusline
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				tabline = {
					lualine_c = {
						{
							function()
								return "%="
							end,
						},
						{
							harpoon_component,
							cond = function()
								return #require("harpoon"):list().items > 0
							end,
							color = { fg = colors.orange, gui = "bold" },
						},
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = { "g:metals_status" },
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(configs.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x at right section
			local function ins_right(component)
				table.insert(configs.sections.lualine_x, component)
			end

			ins_left({
				function()
					return "▊"
				end,
				color = { fg = colors.blue }, -- Sets highlighting of component
				padding = { left = 0, right = 1 }, -- We don't need space before this
			})

			ins_left({
				function()
					local mode_names = {
						n = "NORMAL",
						i = "INSERT",
						v = "VISUAL",
						V = "V-LINE",
						[" "] = "V-BLOCK",
						c = "COMMAND",
						no = "OPERATOR",
						s = "SELECT",
						S = "S-LINE",
						ic = "INSERT",
						R = "REPLACE",
						Rv = "V-REPLACE",
						cv = "VIM EX",
						ce = "NORMAL EX",
						r = "PROMPT",
						rm = "MORE",
						["r?"] = "CONFIRM",
						["!"] = "SHELL",
						t = "TERMINAL",
					}
					local m = vim.fn.mode()
					return " " .. (mode_names[m] or m)
				end,
				color = function()
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						["r?"] = colors.cyan,
						["!"] = colors.red,
						t = colors.red,
					}
					return { fg = mode_color[vim.fn.mode()], gui = "bold" }
				end,
				padding = { right = 1 },
			})
			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.magenta, gui = "bold" },
			})
			ins_left({ "location" })
			-- ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2
			ins_left({
				function()
					return "%="
				end,
			})

			ins_left({
				function()
					local formatters = {}

					local status, conform = pcall(require, "conform")
					if status then
						local l_formatters = conform.list_formatters(0)
						for _, f in ipairs(l_formatters) do
							table.insert(formatters, f.name)
						end
					end

					if #formatters == 0 then
						return ""
					end
					return "󰉼 FMT:" .. table.concat(formatters, ", ")
				end,
				color = { fg = colors.cyan, gui = "bold" },
				cond = conditions.hide_in_width,
			})
			ins_left({
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					return clients[1].name
				end,
				icon = " LSP:",
				color = { fg = colors.fg, gui = "bold" },
			})
			ins_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			})

			-- Add components to right sections
			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})
			ins_right({
				function()
					local current_tab = vim.fn.tabpagenr()
					local total_tabs = vim.fn.tabpagenr("$")
					if total_tabs > 1 then
						return "󰓩 " .. current_tab .. "/" .. total_tabs
					end
					return ""
				end,
				color = { fg = colors.violet, gui = "bold" },
				padding = { left = 1, right = 1 },
			})
			ins_right({
				function()
					return "▊"
				end,
				color = { fg = colors.blue },
				padding = { left = 1 },
			})

			-- Now don't forget to initialize lualine
			lualine.setup(configs)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "HiPhish/nvim-ts-rainbow2" },
		opts_extend = { "ensure_installed" },
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
				"csv",
				"diff",
				"disassembly",
				"dockerfile",
				"git_config",
				"gitignore",
				"html",
				"java",
				"javascript",
				"jq",
				"json",
				"latex",
				"lua",
				"luap",
				"make",
				"markdown",
				"markdown_inline",
				"perl",
				"python",
				"query",
				"regex",
				"scala",
				"sql",
				"ssh_config",
				"toml",
				"tsx",
				"typescript",
				"verilog",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"zathurarc",
			},
			rainbow = {
				enable = false,
				query = { latex = "rainbow-parens" },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- Git labels
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
	},
}
