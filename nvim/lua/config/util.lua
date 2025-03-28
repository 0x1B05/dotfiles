local M = {}

---@param fn fun()
function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end,
    })
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean, buf?:number}
---@return string
function M.get(opts)
    opts = opts or {}
    local buf = opts.buf or vim.api.nvim_get_current_buf()
    local ret = M.cache[buf]
    if not ret then
        local roots = M.detect({ all = false, buf = buf })
        ret = roots[1] and roots[1].paths[1] or vim.uv.cwd()
        M.cache[buf] = ret
    end
    if opts and opts.normalize then
        return ret
    end
    return ret
end

function M.git()
    local root = M.get()
    local git_root = vim.fs.find(".git", { path = root, upward = true })[1]
    local ret = git_root and vim.fn.fnamemodify(git_root, ":h") or root
    return ret
end

function M.float_term(cmd, opts)
    local have_lazy, lazy_util = pcall(require, "lazy.util")
    if have_lazy then
        opts = vim.tbl_deep_extend("force", {
            size = { width = 0.8, height = 0.7 },
        }, opts or {})
        lazy_util.float_term(cmd, opts)
    else
        vim.notify("`lazy.util` not found, abort!", vim.log.levels.WARN)
    end
end

---@param name string
function M.get_plugin(name)
    return require("lazy.core.config").spec.plugins[name]
end

---@param name string
---@param path string?
function M.get_plugin_path(name, path)
    local plugin = M.get_plugin(name)
    path = path and "/" .. path or ""
    return plugin and (plugin.dir .. path)
end

---@param plugin string
function M.has(plugin)
    return M.get_plugin(plugin) ~= nil
end

---@param name string
function M.opts(name)
    local plugin = M.get_plugin(name)
    if not plugin then
        return {}
    end
    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

---@param opts? lsp.Client.format
function M.format(opts)
    opts = vim.tbl_deep_extend(
        "force",
        {},
        opts or {},
        M.opts("nvim-lspconfig").format or {},
        M.opts("conform.nvim").format or {}
    )
    local ok, conform = pcall(require, "conform")
    -- use conform for formatting with LSP when available,
    -- since it has better format diffing
    if ok then
        opts.formatters = {}
        conform.format(opts)
    else
        vim.lsp.buf.format(opts)
    end
end

return M
