return {
    {
        "theniceboy/nvim-deus",
        lazy = true,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme deus]])
        end,
    },
    -- {
    -- 	"rebelot/kanagawa.nvim",
    -- 	lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- 	priority = 0, -- make sure to load this before all the other start plugins
    -- 	config = function()
    -- 		-- load the colorscheme here
    -- 		vim.cmd([[colorscheme kanagawa]])
    -- 	end,
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.
                show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
                term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false, -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15, -- percentage of the shade to apply to the inactive window
                },
                no_italic = false,  -- Force no italic
                no_bold = false,    -- Force no bold
                no_underline = false, -- Force no underline
                styles = {          -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" }, -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    which_key = true,
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
            vim.cmd([[colorscheme catppuccin]])
        end,
    },
}
