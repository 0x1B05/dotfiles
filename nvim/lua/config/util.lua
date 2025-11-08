local M = {}

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
        conform.format(opts)
    else
        vim.lsp.buf.format(opts)
    end
end

return M
