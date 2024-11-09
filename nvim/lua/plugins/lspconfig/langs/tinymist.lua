return {
	offset_encoding = "utf-8",
	cmd = { "tinymist" },
	filetypes = { "typst" },
	root_dir = function()
		return vim.fn.getcwd()
	end,
	single_file_support = true,
	--- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
	settings = {
		exportPdf = "never", -- Choose onType, onSave or never.
		semanticTokens = "disable",
	},
}
