return {
	default_config = {
		cmd = { "typst-lsp" },
		filetypes = { "typst" },
		single_file_support = true,
	},
	settings = {
		exportPdf = "never", -- Choose onType, onSave or never.
		experimentalFormatterMode = "on",
		-- serverPath = "" -- Normally, there is no need to uncomment it.
	},
}
