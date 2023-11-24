local M = {}

M.opt_g = {
	mapleader = ";",
	maplocalleader = ";",
	-- split gdb and source code window vertical
	encoding = "utf-8",
	termdebug_wide = "1",
	markdown_recommended_style = 0,
	-- knap
	knap_settings = {
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
		textopdf = "pdflatex -interaction=batchmode -synctex=1 %docroot%",
		textopdfviewerlaunch = "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
		textopdfviewerrefresh = "none",
		textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
		textopdfshorterror = 'A=%outputfile% ; LOGFILE="${A%.pdf}.log" ; rubber-info "$LOGFILE" 2>&1 | head -n 1',
		delay = 250,
	},
}
M.opt_o = {
	-----------------------------------------------------------
	-- General
	-----------------------------------------------------------
	backup = false,
	clipboard = "unnamedplus", -- Copy/paste to system clipboard
	confirm = true, -- confirm to save changes before exit
	grepformat = "%f:%l:%c:%m",
	grepprg = "rg --vimgrep",
	hlsearch = true,
	ignorecase = true, -- Ignore case
	inccommand = "nosplit",
	incsearch = true,
	mouse = "a", -- Enable mouse support
	number = true,
	pumblend = 10, -- Popup blend
	pumheight = 10, -- Maximum number of entries in a Popup
	relativenumber = true,
	ruler = true,
	scrolloff = 8,
	showmode = false, -- Dont show mode since we have a statusline
	sidescrolloff = 8,
	signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
	smartcase = true,
	spell = true, -- Enable spell check
	spelloptions = "camel", -- Enable camel case
	splitbelow = true, -- Put new windows below current
	splitkeep = "screen",
	splitright = true, -- Put new windows right of current
	swapfile = false, -- Don't use swapfile
	termguicolors = true, -- True color support
	virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
	wildmode = "longest:full,full", -- Command-line completion mode
	winminwidth = 5, -- Minimum window width
	wrap = true,

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
	laststatus = 3,
	list = true, -- Show some invisible characters (tabs...

	-----------------------------------------------------------
	-- Tabs, indent
	-----------------------------------------------------------
	expandtab = true,
	formatoptions = "jqlnt", -- tcqj
	shiftround = true, -- Round indent
	shiftwidth = 4, -- Size of an indent
	smartindent = false, -- Insert indents automatically
	tabstop = 4, -- Number of spaces tabs count for

	-----------------------------------------------------------
	-- Memory, CPU
	-----------------------------------------------------------
	hidden = true, -- Enable background buffers
	history = 1000, -- Remember N lines in history
	lazyredraw = true, -- Faster scrolling
	synmaxcol = 240, -- Max column for syntax highlight
	undolevels = 1000,
	updatetime = 250, -- ms to wait for trigger an event
}
-- to be used by lazy
M.plugins = {
	-- stylua: ignore
	lsp_servers = {
		'clangd',
		'lua_ls',
		'pyright',
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
			formatting.latexindent,
			formatting.markdownlint,
			formatting.shfmt,
			formatting.stylua,

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
