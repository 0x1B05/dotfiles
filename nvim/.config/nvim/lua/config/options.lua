local M = {}

M.opt_g = {
	mapleader = ";",
	maplocalleader = ";",
	-- split gdb and source code window vertical
	encoding = "utf-8",
	termdebug_wide = "1",
	markdown_recommended_style = 0,
	-- knap
	knap_setting = {
		htmloutputext = "html",
		htmltohtml = "none",
		htmltohtmlviewerlaunch = "falkon %outputfile%",
		htmltohtmlviewerrefresh = "none",
		mdoutputext = "html",
		mdtohtml = "pandoc --standalone %docroot% -o %outputfile%",
		mdtohtmlviewerlaunch = "falkon %outputfile%",
		mdtohtmlviewerrefresh = "none",
		mdtopdf = "pandoc %docroot% -o %outputfile%",
		mdtopdfviewerlaunch = "sioyek %outputfile%",
		mdtopdfviewerrefresh = "none",
		markdownoutputext = "html",
		markdowntohtml = "pandoc --standalone %docroot% -o %outputfile%",
		markdowntohtmlviewerlaunch = "falkon %outputfile%",
		markdowntohtmlviewerrefresh = "none",
		markdowntopdf = "pandoc %docroot% -o %outputfile%",
		markdowntopdfviewerlaunch = "sioyek %outputfile%",
		markdowntopdfviewerrefresh = "none",
		texoutputext = "pdf",
		textopdf = "pdflatex -interaction=batchmode -halt-on-error -synctex=1 %docroot%",
		textopdfviewerlaunch = "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
		textopdfviewerrefresh = "none",
		textopdfforwardjump = "zathura, --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
		textopdfshorterror = 'A=%outputfile% ; LOGFILE="${A%.pdf}.log" ; rubber-info "$LOGFILE" 2>&1 | head -n 1',
		delay = 250,
	},
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
		'pyright',
		'lua_ls',
		'rust_analyzer',
	},

	-- null-ls sources: formatter and linter
	nls_sources = function(nls)
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
		local formatting = nls.builtins.formatting
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
		local diagnostics = nls.builtins.diagnostics
		return {
			-- formatters
			formatting.clang_format.with({
				extra_args = {
					"-style={BasedOnStyle: Google, IndentWidth: 4, DerivePointerAlignment: true, PointerAlignment: Right }",
				},
			}),
			formatting.stylua,
			formatting.shfmt,
			formatting.latexindent,
			formatting.markdownlint,

			-- linters
			diagnostics.clang_check,
			diagnostics.flake8,
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
