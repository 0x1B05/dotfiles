local keymaps = require("config.keymaps")

return {
    { "folke/lazy.nvim", version = "*" },
    -- file explorer
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = keymaps.yazi1,
        ---@type YaziConfig
        opts = {
            open_for_directories = false,
            open_multiple_tabs = true,

            highlight_hovered_buffers_in_same_directory = true,
            highlight_groups = {
                -- hovered_buffer = nil,
                -- hovered_buffer_in_same_directory = nil,
            },

            use_ya_for_events_reading = true,
            floating_window_scaling_factor = 0.8,
            yazi_floating_window_winblend = 0,

            log_level = vim.log.levels.OFF,
            keymaps = keymaps.yazi2,
            yazi_floating_window_border = "rounded",
            clipboard_register = "*",

            integrations = {
                -- default: telescope.nvim
                -- grep_in_directory = function(directory)
                -- end,
                -- grep_in_selected_files = function(selected_files)
                -- end,

                -- default: grug-far.nvim
                -- replace_in_directory = function(directory)
                -- end,
                -- replace_in_selected_files = function(selected_files)
                -- end,

                -- resolve_relative_path_application = "",
            },

            future_features = {
                ya_emit_reveal = true,
                ya_emit_open = true,
            },
        },
    },
    -- search/replace in multiple files
    {
        "MagicDuck/grug-far.nvim",
        opts = { headerMaxWidth = 80 },
        cmd = "GrugFar",
        keys = keymaps.grug_far,
    },
    -- session management
    {
        "folke/persistence.nvim",
        lazy = true,
        keys = keymaps.persistence,
        opts = {
            options = { "buffers", "curdir", "tabpages", "winsize", "help" },
            pre_save = nil,
        },
        config = function(_, opts)
            -- setup config only, no auto save
            require("persistence.config").setup(opts)
        end,
    },
    -- hint with which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            defaults = {},
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>c", group = "code" },
                    { "<leader>f", group = "file/find" },
                    { "<leader>g", group = "git" },
                    { "<leader>gh", group = "hunks" },
                    { "<leader>q", group = "quit/session" },
                    { "<leader>s", group = "search" },
                    { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                    { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "gs", group = "surround" },
                    { "z", group = "fold" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                    -- better descriptions
                    { "gx", desc = "Open with system app" },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
        end,
    },
    {
        "aserowy/tmux.nvim",
        event = "VeryLazy",
        config = function()
            require("tmux").setup({
                sync_clipboard = false,
                sync_unnamed = false,
                keys = keymaps.tmux,
                resize = { -- enables default keybindings (A-hjkl) for normal mode
                    enable_default_keybindings = false,
                    -- sets resize steps for x axis
                    resize_step_x = 5,
                    -- sets resize steps for y axis
                    resize_step_y = 5,
                },
            })
        end,
    },
    {
        "TobinPalmer/pastify.nvim",
        cmd = { "Pastify" },
        config = function()
            require("pastify").setup({
                opts = {
                    absolute_path = false,  -- use absolute or relative path to the working directory
                    apikey = "",            -- Api key, required for online saving
                    local_path = "images/", -- The path to put local files in, ex ~/Projects/<name>/images/<imgname>.png
                    save = "local",         -- Either 'local' or 'online'
                },
                ft = {                      -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html = '<img src="$IMG$" alt="">',
                    markdown = "![]($IMG$)",
                    typst = '#figure(caption: [])[#image("$IMG$")]',
                    tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            })
        end,
    },
}
