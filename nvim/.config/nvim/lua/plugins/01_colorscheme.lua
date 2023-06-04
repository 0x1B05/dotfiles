return {
    {
        "folke/tokyonight.nvim",
        lazy = true, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
        end,
    },
    {
        "catppuccin/nvim",
        lazy = true, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
          -- load the colorscheme here
          vim.cmd[[colorscheme kanagawa]]
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = true, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
        end,
    }
}
