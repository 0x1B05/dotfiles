return {
	default_config = {
		cmd = { "typst-lsp" },
		filetypes = { "typst" },
		single_file_support = true,
	},
	settings = {
		exportPdf = "onSave", -- Choose onType, onSave or never.
		-- serverPath = "" -- Normally, there is no need to uncomment it.
	},
}
