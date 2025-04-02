local util = require("config.util")
local keymaps = require("config.keymaps")

return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = keymaps.lsp,
        dependencies = {
            -- load for lsp server setup
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            {
                "hrsh7th/cmp-nvim-lsp",
                config = function()
                    return util.has("nvim-cmp")
                end,
            },
        },
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    -- prefix = "icons",
                },
                severity_sort = true,
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enabled = false,
            },
            -- add any global capabilities here
            capabilities = {},
            -- Automatically format on save
            autoformat = true,
            -- Enable this to show formatters used in a notification
            -- Useful for debugging formatter issues
            format_notify = false,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            servers = {
                clangd = require("plugins.lspconfig.langs.clangd"),
                cmake = require("plugins.lspconfig.langs.cmake-language-server"),
                lua_ls = require("plugins.lspconfig.langs.lua_ls"),
                tinymist = require("plugins.lspconfig.langs.tinymist"),
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            setup = {
                clangd = function(_, opts)
                    local clangd_ext_opts = require("lazy.core.plugin").values("clangd_extensions.nvim", "opts", false)
                    require("clangd_extensions").setup(
                        vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
                    )
                    return false
                end,
            },
        },

        config = function(_, opts)
            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})
                if server_opts.enabled == false then
                    return
                end

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available thourgh mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = require("config.options").plugins.lsp_servers
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
            end
        end,
    },
    -- manage LSP servers, DAP servers, linters, and formatters
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = { -- required for :Mason
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
            ui = {
                -- disable check on :Mason window
                check_outdated_packages_on_open = false,
                border = "rounded",
                width = 0.8,
                height = 0.8,
                icons = {
                    package_installed = "◍",
                    package_pending = "◍",
                    package_uninstalled = "◍",
                },
            },
        },
    },
    -- easy lspconfig: implicitly load mason and auto install lsp servers
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        opts = {
            ensure_installed = require("config.options").plugins.lsp_servers,
            automatic_installation = false,
        },
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },

    -- formatter
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        lazy = true,
        cmd = "ConformInfo",
        opts = {
            default_format_opts = {
                timeout_ms = 3000,
                async = false,           -- not recommended to change
                quiet = false,           -- not recommended to change
                lsp_format = "fallback", -- not recommended to change
            },
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                scala = { "scalafmt" },
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_format" }
                    else
                        return { "isort", "black" }
                    end
                end,
                bash = { "shfmt" },
                sh = { "shfmt" },
                lua = { "stylua" },
                typst = { "typstyle" },
                html = { "prettier" },
                markdown = { 'prettier' },
                javascript = { "prettier" },
                typescript = { "prettier" },
                vue = { "prettier" },
                verilog = { "verible" },
            },
            formatters = {
                clang_format = {
                    command = "clang-format",
                    -- "--style={BasedOnStyle: Google, IndentWidth: 4, DerivePointerAlignment: true, PointerAlignment: Right, SortIncludes: false}",
                    args = {
                        [[--style="{
                        BasedOnStyle: Google,
                        IndentWidth: 4,
                        ColumnLimit: 88,
                        AlignAfterOpenBracket: Align,
                        AlignTrailingComments: true,
                        DerivePointerAlignment: true,
                        PointerAlignment: Right,
                        SortIncludes: false
                    }"]],
                        "-i"
                    },
                    stdin = true
                },
            },
            log_level = vim.log.levels.ERROR,
        },
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePost", "BufReadPost", "InsertLeave" },
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                markdown = { "markdownlint" },
                cpp = { "verilator" },
            },
            ---@type table<string,table>
            linters = {
                verilator = {
                    args = {
                        "--lint-only",
                        "-F",
                        vim.fs.find("verilator.f", {
                            upward = true,
                            stop = "/home",
                            type = "file",
                        })[1],
                    },
                },
            },
        },
        config = function(_, opts)
            local M = {}

            local lint = require("lint")
            for name, linter in pairs(opts.linters) do
                if type(linter) == "table" and type(lint.linters[name]) == "table" then
                    lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
                    if type(linter.prepend_args) == "table" then
                        lint.linters[name].args = lint.linters[name].args or {}
                        vim.list_extend(lint.linters[name].args, linter.prepend_args)
                    end
                else
                    lint.linters[name] = linter
                end
            end
            lint.linters_by_ft = opts.linters_by_ft

            function M.debounce(ms, fn)
                local timer = vim.uv.new_timer()
                return function(...)
                    local argv = { ... }
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(unpack(argv))
                    end)
                end
            end

            function M.lint()
                -- Use nvim-lint's logic first:
                -- * checks if linters exist for the full filetype first
                -- * otherwise will split filetype by "." and add all those linters
                -- * this differs from conform.nvim which only uses the first filetype that has a formatter
                local names = lint._resolve_linter_by_ft(vim.bo.filetype)

                -- Create a copy of the names table to avoid modifying the original.
                names = vim.list_extend({}, names)

                -- Add fallback linters.
                if #names == 0 then
                    vim.list_extend(names, lint.linters_by_ft["_"] or {})
                end

                -- Add global linters.
                vim.list_extend(names, lint.linters_by_ft["*"] or {})

                -- Filter out linters that don't exist or don't match the condition.
                local ctx = { filename = vim.api.nvim_buf_get_name(0) }
                ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
                names = vim.tbl_filter(function(name)
                    local linter = lint.linters[name]
                    if not linter then
                        util.warn("Linter not found: " .. name, { title = "nvim-lint" })
                    end
                    return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
                end, names)

                -- Run linters.
                if #names > 0 then
                    lint.try_lint(names)
                end
            end

            vim.api.nvim_create_autocmd(opts.events, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = M.debounce(100, M.lint),
            })
        end,
    },

    -- cpp
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        config = function() end,
        opts = {
            inlay_hints = {
                inline = false,
            },
            ast = {
                --These require codicons (https://github.com/microsoft/vscode-codicons)
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },
                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },
            },
        },
    },
    -- typst
    {
        "kaarmu/typst.vim",
        lazy = true,
        ft = "typst",
    },
    -- latex
    {
        "frabjous/knap",
        enabled = true,
        keys = keymaps.knap,
        ft = { "tex", "markdown" },
    },
}
