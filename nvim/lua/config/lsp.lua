local keymaps = require("config.keymaps")

local M = {}

function M.capabilities()
	return require("blink.cmp").get_lsp_capabilities()
end

function M.on_attach(_, bufnr)
	if not keymaps.lsp then
		return
	end

	for _, key in ipairs(keymaps.lsp) do
		local mode = key.mode or "n"
		local lhs = key[1]
		local rhs = key[2]
		local opts = { desc = key.desc, buffer = bufnr }
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

function M.extend(server_opts)
	local opts = vim.deepcopy(server_opts or {})
	local server_on_attach = opts.on_attach

	opts.capabilities = vim.tbl_deep_extend("force", M.capabilities(), opts.capabilities or {})
	opts.on_attach = function(client, bufnr)
		M.on_attach(client, bufnr)
		if server_on_attach then
			server_on_attach(client, bufnr)
		end
	end

	return opts
end

return M
