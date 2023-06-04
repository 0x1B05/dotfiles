require("config.options").load_options()
require("config.lazy").check_load_lazy()

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.keymaps")
        require("config.autocmds")
    end,
})
