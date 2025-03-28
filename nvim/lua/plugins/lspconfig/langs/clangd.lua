local util = require("plugins.lspconfig.util")

-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
local function switch_source_header(bufnr)
    bufnr = util.validate_bufnr(bufnr)
    local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    if clangd_client then
        clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
            if err then
                error(tostring(err))
            end
            if not result then
                print("Corresponding file cannot be determined")
                return
            end
            vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
        end, bufnr)
    else
        print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
    end
end

local function symbol_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
    if not clangd_client or not clangd_client.supports_method("textDocument/symbolInfo") then
        return vim.notify("Clangd client not found", vim.log.levels.ERROR)
    end
    local win = vim.api.nvim_get_current_win()
    local params = vim.lsp.util.make_position_params(win, clangd_client.offset_encoding)
    clangd_client.request("textDocument/symbolInfo", params, function(err, res)
        if err or #res == 0 then
            -- Clangd always returns an error, there is not reason to parse it
            return
        end
        local container = string.format("container: %s", res[1].containerName) ---@type string
        local name = string.format("name: %s", res[1].name) ---@type string
        vim.lsp.util.open_floating_preview({ name, container }, "", {
            height = 2,
            width = math.max(string.len(name), string.len(container)),
            focusable = false,
            focus = false,
            border = "single",
            title = "Symbol Info",
        })
    end, bufnr)
end

return {
    keys = {
        { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
    },

    cmd = {
        "clangd",
        "--all-scopes-completion",
        "--suggest-missing-includes",
        "--background-index",
        "--pch-storage=disk",
        "--cross-file-rename",
        "--completion-style=detailed",
        "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
        "--clang-tidy",
        "--offset-encoding=utf-16",
        "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
        "--fallback-style=Google",
        "--header-insertion=iwyu",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = function(fname)
        return util.root_pattern(
            ".clang-format",
            ".clang-tidy",
            ".clangd",
            "Makefile",
            "build.ninja",
            "compile_commands.json",
            "compile_flags.txt",
            "config.h.in",
            "configure.ac",
            "configure.in",
            "meson.build",
            "meson_options.txt"
        )(fname) or util.root_pattern("compile_commands.json", "compile_flags.txt")(fname) or util.find_git_ancestor(
            fname
        )
    end,
    single_file_support = true,
    capabilities = {
        offsetEncoding = { "utf-16" },
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    commands = {
        ClangdSwitchSourceHeader = {
            function()
                switch_source_header(0)
            end,
            description = "Switch between source/header",
        },
        ClangdShowSymbolInfo = {
            function()
                symbol_info()
            end,
            description = "Show symbol info",
        },
    },
}
