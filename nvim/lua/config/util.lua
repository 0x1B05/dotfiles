local M = {}

M.root_patterns = { ".git", "lua" }

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

---@param plugin string
function M.has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

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
---@return string
function M.get_root()
	---@type string?
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	---@type string[]
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	---@type string?
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		---@type string?
		root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	---@cast root string
	return root
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

function M.format()
	local buf = vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype

	-- stylua: ignore
	local have_nls = #require('null-ls.sources').get_available(ft, 'NULL_LS_FORMATTING') > 0

	-- prefer null-ls formatter
	local fmt_filter = function(client)
		if have_nls then
			return client.name == "null-ls"
		end
		return client.name ~= "null-ls"
	end

	vim.lsp.buf.format({
		bufnr = buf,
		filter = fmt_filter,
		timeout_ms = require("config.options").plugins.fmt_timeout_ms,
	})
end

return M
