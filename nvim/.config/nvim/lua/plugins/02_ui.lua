return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = {
				char = "▎",
				tab_char = nil,
				highlight = "IblIndent",
				smart_indent_cap = true,
				priority = 1,
			},
			whitespace = {
				highlight = "IblWhitespace",
				remove_blankline_trail = true,
			},
			scope = {
				enabled = true,
				char = nil,
				show_start = true,
				show_end = true,
				injected_languages = true,
				highlight = "IblScope",
				priority = 1024,
				include = {
					node_type = {},
				},
				exclude = {
					language = {},
					node_type = {
						["*"] = {
							"source_file",
							"program",
						},
						lua = {
							"chunk",
						},
						python = {
							"module",
						},
					},
				},
			},
			exclude = {
				filetypes = {
					"lspinfo",
					"packer",
					"checkhealth",
					"help",
					"man",
					"gitcommit",
					"TelescopePrompt",
					"TelescopeResults",
					"",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = { relative = "editor" },
			select = {
				backend = { "telescope", "fzf", "builtin" },
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
				middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
				-- NOTE: this plugin is designed with this icon in mind,
				-- and so changing this is NOT recommended, this is intended
				-- as an escape hatch for people who cannot bear it for whatever reason
				indicator_icon = nil,
				indicator = { style = "icon", icon = "▎" },
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
				tab_size = 21,
				diagnostics = false, -- | "nvim_lsp" | "coc",
				diagnostics_update_in_insert = false,
				offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
				enforce_regular_tabs = true,
				always_show_bufferline = true,
			},
			highlights = {
				fill = {
					fg = { attribute = "fg", highlight = "Visual" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				background = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				buffer_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				close_button = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				close_button_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				tab_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				tab = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				tab_close = {
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				duplicate_selected = {
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "TabLineSel" },
					underline = true,
				},
				duplicate_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					underline = true,
				},
				duplicate = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					underline = true,
				},
				modified = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				modified_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				modified_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				separator = {
					fg = { attribute = "bg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},
				separator_selected = {
					fg = { attribute = "bg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
				indicator_selected = {
					fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
			},
		},
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
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
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
				-- mode component
				function()
					return ""
				end,
				color = function()
					-- auto change color according to neovims mode
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[""] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						[""] = colors.orange,
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
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			})

			ins_left({
				-- filesize component
				"filesize",
				cond = conditions.buffer_not_empty,
			})

			ins_left({
				"filename",
				cond = conditions.buffer_not_empty,
				color = { fg = colors.magenta, gui = "bold" },
			})

			ins_left({ "location" })

			ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

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

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2
			ins_left({
				function()
					return "%="
				end,
			})

			ins_left({
				-- Lsp server name .
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = " LSP:",
				color = { fg = "#ffffff", gui = "bold" },
			})

			-- Add components to right sections
			ins_right({
				"o:encoding", -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"fileformat",
				fmt = string.upper,
				icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
				color = { fg = colors.green, gui = "bold" },
			})

			ins_right({
				"branch",
				icon = "",
				color = { fg = colors.violet, gui = "bold" },
			})

			ins_right({
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
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
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "HiPhish/nvim-ts-rainbow2" },
		keys = {
			{ "<cr>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			autopairs = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"vimdoc",
				"html",
				"javascript",
				"css",
				"json",
				"dockerfile",
				"verilog",
				"latex",
				"lua",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				-- "typescript",
				"vim",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},
			rainbow = {
				enable = true,
				query = { latex = "rainbow-parens" },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				[[                            ⡿⠉⠄⠄⠄⠄⠈⠙⠿⠟⠛⠉⠉⠉⠄⠄⠄⠈⠉⠉⠉⠛⠛⠻⢿⣿⣿⣿⣿⣿                        ]],
				[[                            ⠁⠄⠄⠄⢀⡴⣋⣵⣮⠇⡀⠄⠄⠄⠄⠄⠄⢀⠄⠄⠄⡀⠄⠄⠄⠈⠛⠿⠋⠉                        ]],
				[[                            ⠄⠄⠄⢠⣯⣾⣿⡿⣳⡟⣰⣿⣠⣂⡀⢀⠄⢸⡄⠄⢀⣈⢆⣱⣤⡀⢄⠄⠄⠄                        ]],
				[[                            ⠄⠄⠄⣼⣿⣿⡟⣹⡿⣸⣿⢳⣿⣿⣿⣿⣴⣾⢻⣆⣿⣿⣯⢿⣿⣿⣷⣧⣀⣤                        ]],
				[[                            ⠄⠄⣼⡟⣿⠏⢀⣿⣇⣿⣏⣿⣿⣿⣿⣿⣿⣿⢸⡇⣿⣿⣿⣟⣿⣿⣿⣿⣏⠋                        ]],
				[[                            ⡆⣸⡟⣼⣯⠏⣾⣿⢸⣿⢸⣿⣿⣿⣿⣿⣿⡟⠸⠁⢹⡿⣿⣿⢻⣿⣿⣿⣿⠄                        ]],
				[[                            ⡇⡟⣸⢟⣫⡅⣶⢆⡶⡆⣿⣿⣿⣿⣿⢿⣛⠃⠰⠆⠈⠁⠈⠙⠈⠻⣿⢹⡏⠄                        ]],
				[[                            ⣧⣱⡷⣱⠿⠟⠛⠼⣇⠇⣿⣿⣿⣿⣿⣿⠃⣰⣿⣿⡆⠄⠄⠄⠄⠄⠉⠈⠄⠄                        ]],
				[[ ▄▄▄     ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄    ⡏⡟⢑⠃⡠⠂⠄⠄⠈⣾⢻⣿⣿⡿⡹⡳⠋⠉⠁⠉⠙⠄⢀⠄⠄⠄⠄⠄⠂⠄    ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ ]],
				[[█   █   █       █       █   ⡇⠁⢈⢰⡇⠄⠄⡙⠂⣿⣿⣿⣿⣱⣿⡗⠄⠄⠄⢀⡀⠄⠈⢰⠄⠄⠄⠐⠄⠄   █  █ █  █   █  █▄█  █]],
				[[█   █   █    ▄▄▄█   ▄   █   ⠄⠄⠘⣿⣧⠴⣄⣡⢄⣿⣿⣿⣷⣿⣿⡇⢀⠄⠤⠈⠁⣠⣠⣸⢠⠄⠄⠄⠄⠄   █  █▄█  █   █       █]],
				[[█   █   █   █▄▄▄█  █ █  █   ⢀⠄⠄⣿⣿⣷⣬⣵⣿⣿⣿⣿⣿⣿⣿⣷⣟⢷⡶⢗⡰⣿⣿⠇⠘⠄⠄⠄⠄⠄   █       █   █       █]],
				[[█   █▄▄▄█    ▄▄▄█  █▄█  █   ⣿⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣾⣿⣿⡟⢀⠃⠄⢸⡄⠁⣸   █       █   █       █]],
				[[█       █   █▄▄▄█       █   ⣿⠄⠄⠘⢿⣿⣿⣿⣿⣿⣿⢛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⢄⡆⠄⢀⣪⡆⠄⣿    █     ██   █ ██▄██ █]],
				[[█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█   ⡟⠄⠄⠄⠄⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣟⣻⣩⣾⣃⣴⣿⣿⡇⠸⢾     █▄▄▄█ █▄▄▄█▄█   █▄█]],
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", "󱎸  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
				dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
