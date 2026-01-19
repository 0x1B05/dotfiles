local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "InsertEnter" }, { pattern = "*", command = "set timeoutlen=200" })
vim.api.nvim_create_autocmd({ "InsertLeave" }, { pattern = "*", command = "set timeoutlen=1000" })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query", -- :InspectTree
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"vim",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})
-- reload config on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "**/lua/config/*.lua",
	callback = function()
		local filepath = vim.fn.expand("%")
		dofile(filepath)
		vim.notify("Configuration reloaded \n" .. filepath, nil)
	end,
	group = augroup("reload_on_save"),
	desc = "Reload config on save",
})
-- check xelatex
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.tex" },
	callback = function()
		local isxelatex = false
		local fifteenlines = vim.api.nvim_buf_get_lines(0, 0, 15, false)
		for _, line in ipairs(fifteenlines) do
			if
				(line:lower():match("xelatex"))
				or (line:match("\\usepackage[^}]*mathspec"))
				or (line:match("\\usepackage[^}]*fontspec"))
				or (line:match("\\usepackage[^}]*unicode-math"))
			then
				isxelatex = true
				break
			end
		end
		if isxelatex then
			local knapsettings = vim.b.knap_settings or {}
			knapsettings["textopdf"] = "xelatex -interaction=batchmode -synctex=1 %docroot%"
			vim.b.knap_settings = knapsettings
		end
	end,
	group = augroup("latex"),
	desc = "Xelatex check",
})

vim.api.nvim_create_autocmd({
	"BufNewFile",
	"BufRead",
}, {
	pattern = "*.typ",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_set_option_value("modeline", false, { buf = buf })
	end,
})
-- auto-save
-- local function save()
--   local buf = vim.api.nvim_get_current_buf()
--
--   vim.api.nvim_buf_call(buf, function()
--     vim.cmd("silent! write")
--   end)
-- end
--
-- vim.api.nvim_create_augroup("AutoSave", {
--   clear = true,
-- })
--
-- vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
--   callback = function()
--     save()
--   end,
--   pattern = "*",
--   group = "AutoSave",
-- })
