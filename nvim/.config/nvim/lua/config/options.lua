local M = {}

M.opt_g = {
	mapleader = ";",
	maplocalleader = ";",
	-- split gdb and source code window vertical
	encoding = "utf-8",
	termdebug_wide = "1",
	markdown_recommended_style = 0,
}
M.opt_o = {
	-----------------------------------------------------------
	-- General
	-----------------------------------------------------------
	mouse = "a", -- Enable mouse support
	clipboard = "unnamedplus", -- Copy/paste to system clipboard
	swapfile = false, -- Don't use swapfile
	confirm = true, -- confirm to save changes before exit
	backup = false,
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
	pumblend = 10, -- Popup blend
	pumheight = 10, -- Maximum number of entries in a Popup
	splitbelow = true, -- Put new windows below current
	splitright = true, -- Put new windows right of current
	termguicolors = true, -- True color support
	winminwidth = 5, -- Minimum window width
	spell = true, -- Enable spell check
	spelloptions = "camel", -- Enable camel case
	smartcase = true,
	termencoding = "utf-8",
	syntax = "enable",
	wrap = true,
	ruler = true,
	incsearch = true,
	hlsearch = true,
	number = true,
	relativenumber = true,
	scrolloff = 8,
	sidescrolloff = 8,

	-----------------------------------------------------------
	-- Code Fold
	-----------------------------------------------------------
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    foldlevel = 99,

	-----------------------------------------------------------
	-- Neovim UI
	-----------------------------------------------------------
	cursorline = true, -- highlight cursorline
	list = true, -- Show some invisible characters (tabs...

	-----------------------------------------------------------
	-- Tabs, indent
	-----------------------------------------------------------
	formatoptions = "jqlnt", -- tcqj
	shiftround = true, -- Round indent
	tabstop = 4, -- Number of spaces tabs count for
	shiftwidth = 4, -- Size of an indent
	smartindent = false, -- Insert indents automatically
	expandtab = true,

	-----------------------------------------------------------
	-- Memory, CPU
	-----------------------------------------------------------
	undolevels = 1000,
	hidden = true, -- Enable background buffers
	history = 1000, -- Remember N lines in history
	lazyredraw = true, -- Faster scrolling
	synmaxcol = 240, -- Max column for syntax highlight
	updatetime = 250, -- ms to wait for trigger an event
}
-- to be used by lazy
M.plugins = {
	-- stylua: ignore
	lsp_servers = {
		'clangd',
		'gopls',
		'pyright',
		'lua_ls',
		'rust_analyzer',
	},

	-- null-ls sources: formatter and linter
	nls_sources = function(nls)
		return {
			-- formatters
			nls.builtins.formatting.clang_format,
			nls.builtins.formatting.gofmt,
			nls.builtins.formatting.rustfmt,
			nls.builtins.formatting.yapf,
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.shfmt,

			-- linters
			nls.builtins.diagnostics.clang_check,
			nls.builtins.diagnostics.flake8,
		}
	end,

	-- lsp format timeout
	fmt_timeout_ms = 4000,
}

-- stylua: ignore
function M.load_options()
	for k, v in pairs(M.opt_o) do vim.o[k] = v end
	for k, v in pairs(M.opt_g) do vim.g[k] = v end
end


return M
