return {
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                numbers = "none",                    -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
                close_command = "Bdelete! %d",       -- can be a string | function, see "Mouse actions"
                right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
                left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
                middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
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
                diagnostics = false,    -- | "nvim_lsp" | "coc",
                diagnostics_update_in_insert = false,
                offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                separator_style = "thin",   -- | "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = true,
                always_show_bufferline = true,
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
                    lualine_c = { 'g:metals_status' },
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
                color = { fg = colors.blue },      -- Sets highlighting of component
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
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                    local clients = vim.lsp.get_clients()
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
                icon = ' LSP:',
                color = { fg = '#ffffff', gui = 'bold' },
            })

            -- Add components to right sections
            ins_right({
                "o:encoding",       -- option component same as &encoding in viml
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
            signs                        = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged                 = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged_enable          = true,
            signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                follow_files = true
            },
            auto_attach                  = true,
            attach_to_untracked          = false,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
            current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil,   -- Use default
            max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            preview_config               = {
                -- Options passed to nvim_open_win
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
        },
    },
}
