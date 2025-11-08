local M = {}

function M.check_load_lazy()
    vim.lsp.set_log_level("WARN")
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out,                            "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)
    M.load_lazy()
end

-- Configure lazy.nvim
-- https://lazy.folke.io/configuration
function M.load_lazy()
    require("lazy").setup({
        root = vim.fn.stdpath("data") .. "/lazy",
        defaults = {
            lazy = true,
            version = "*",
        },
        spec = { { import = "plugins", }, },

        install = {
            missing = true,
            colorscheme = { "tokyonight" },
        },
        ui = {
            size = { width = 0.8, height = 0.8 },
            wrap = true,
            border = "none",
            title = nil,
            title_pos = "center",
            icons = {
                cmd = " ",
                config = "",
                event = "",
                ft = " ",
                init = " ",
                import = " ",
                keys = " ",
                lazy = "󰒲 ",
                loaded = "●",
                not_loaded = "○",
                plugin = " ",
                runtime = " ",
                source = " ",
                start = "",
                task = "✔ ",
                list = { "●", "➜", "★", "‒", },
            },
            browser = nil,
            throttle = 20,
        },
        checker = {
            enabled = false,
            concurrency = nil, ---@type number? set to 1 to check for updates very slowly
            notify = true,
            frequency = 3600 * 24 * 7, -- check for updates every week
        },
        change_detection = {
            enabled = false,
            notify = false,
        },
        performance = {
            cache = {
                enabled = true,
            },
            rtp = {
                reseet = true,
                paths = {},
                -- disable some rtp plugins
                disabled_plugins = {
                    "2html_plugin",
                    "getscript",
                    "getscriptPlugin",
                    "gzip",
                    "logipat",
                    "netrw",
                    "netrwPlugin",
                    "netrwSettings",
                    "netrwFileHandlers",
                    "matchit",
                    "tar",
                    "tarPlugin",
                    "rrhelper",
                    "spellfile_plugin",
                    "vimball",
                    "vimballPlugin",
                    "zip",
                    "zipPlugin",
                    "tutor",
                    "rplugin",
                    "synmenu",
                    "optwin",
                    "compiler",
                    "bugreport",
                    "ftplugin",
                },
            },
        },
    })
end

return M
