return {
    offset_encoding = "utf-16",
    cmd = { "tinymist" },
    filetypes = { "typst" },
    root_dir = function(fname)
        local candidates = vim.fs.find(
            { "main.typ", ".git" },
            { path = fname, upward = true, stop = vim.env.HOME }
        )

        for _, path in ipairs(candidates) do
            if vim.endswith(path, "main.typ") then
                return vim.fs.dirname(path)
            end
            if vim.endswith(path, ".git") then
                return vim.fs.dirname(path)
            end
        end

        return vim.fs.dirname(fname)
    end,
    single_file_support = true,
    --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
    settings = {
        exportPdf = "never", -- Choose onType, onSave or never.
        semanticTokens = "disable",
        formatterMode = "typstyle"
    },
}
