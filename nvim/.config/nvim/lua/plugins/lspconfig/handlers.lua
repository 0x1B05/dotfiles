local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true,
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end


M.on_attach = function(client, bufnr)
	-- if client.name == "tsserver" then
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- end
	--
	-- if client.name == "sumneko_lua" then
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- end

end

M.root_pattern = function(...)
	local patterns = vim.tbl_flatten({ ... })
	local function matcher(path)
		for _, pattern in ipairs(patterns) do
			for _, p in ipairs(vim.fn.glob(M.path.join(M.path.escape_wildcards(path), pattern), true, true)) do
				if M.path.exists(p) then
					return path
				end
			end
		end
	end
	return function(startpath)
		startpath = M.strip_archive_subpath(startpath)
		return M.search_ancestors(startpath, matcher)
	end
end
M.validate_bufnr = function(bufnr)
  vim.validate {
    bufnr = { bufnr, 'n' },
  }
  return bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
end
M.find_git_ancestor = function(startpath)
  return M.search_ancestors(startpath, function(path)
    -- Support git directories and git files (worktrees)
    if M.path.is_dir(M.path.join(path, '.git')) or M.path.is_file(M.path.join(path, '.git')) then
      return path
    end
  end)
end
M.get_active_client_by_name = function(bufnr, servername)
  for _, client in pairs(vim.lsp.get_active_clients { bufnr = bufnr }) do
    if client.name == servername then
      return client
    end
  end
end
return M
