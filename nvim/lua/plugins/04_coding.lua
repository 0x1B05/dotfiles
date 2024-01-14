local keymaps = require("config.keymaps")
return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
            require("luasnip").config.set_config({
                enable_autosnippets = true,
                store_selection_keys = "<A-p>",
                history = false,
                -- Event on which to check for exiting a snippet's region
                region_check_events = "InsertEnter",
                delete_check_events = "InsertLeave",
                update_events = "TextChanged,TextChangedI",
                ext_opts = {
                    [require("luasnip.util.types").choiceNode] = {
                        active = {
                            virt_text = { { "●", "GruvboxOrange" } },
                        },
                    },
                },
            })
            require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/plugins/luasnip" })
            local auto_expand = require("luasnip").expand_auto
            require("luasnip").expand_auto = function(...)
                vim.o.undolevels = vim.o.undolevels
                auto_expand(...)
            end
        end,
    },

    -- surround
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },

    -- comments
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        keys = keymaps.comment,
        config = function()
            require("Comment").setup({
                ---Add a space b/w comment and the line
                padding = true,
                ---Whether the cursor should stay at its position
                sticky = true,
                ---Lines to be ignored while (un)comment
                ignore = nil,
                ---LHS of toggle mappings in NORMAL mode
                toggler = {
                    line = "gcc",
                    block = "gbc",
                },
                ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                opleader = {
                    line = "gc",
                    block = "gb",
                },
                ---LHS of extra mappings
                extra = {
                    above = "gcO",
                    below = "gco",
                    ---Add comment at the end of line
                    eol = "gcA",
                },
                ---Enable keybindings
                ---NOTE: If given `false` then the plugin won't create any mappings
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = true,
                },
                pre_hook = function(ctx)
                    local U = require("Comment.utils")

                    local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
                    if not status_utils_ok then
                        return
                    end

                    local location = nil
                    if ctx.ctype == U.ctype.block then
                        location = utils.get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = utils.get_visual_start_location()
                    end

                    local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
                    if not status_internals_ok then
                        return
                    end

                    return internals.calculate_commentstring({
                        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
                        location = location,
                    })
                end,
            })
        end,
    },

    -- auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            disable_filetype = { "TelescopePrompt", "spectre_panel" },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'", "`", "<" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0, -- Offset from pattern match
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        },
    },

    -- toggleterm
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        version = "*",
        keys = keymaps.toggleterm,
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
            local Terminal = require("toggleterm.terminal").Terminal

            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end

            local node = Terminal:new({ cmd = "node", hidden = true })
            function _NODE_TOGGLE()
                node:toggle()
            end

            local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
            function _NCDU_TOGGLE()
                ncdu:toggle()
            end

            local htop = Terminal:new({ cmd = "htop", hidden = true })
            function _HTOP_TOGGLE()
                htop:toggle()
            end

            local python = Terminal:new({ cmd = "python", hidden = true })
            function _PYTHON_TOGGLE()
                python:toggle()
            end
        end,
    },

    --{
    --    "mg979/vim-visual-multi",
    --},
    --{
    --    "tpope/vim-repeat",
    --}
}
