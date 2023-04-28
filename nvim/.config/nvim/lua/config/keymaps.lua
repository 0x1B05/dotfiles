-- This file is automatically loaded by init.lua

-- local util = require("util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

--键盘映射
map({ "n", "v", "o" }, "H", "^",{ desc = "Use 'H' as '^'" })
map({ "n", "v", "o" }, "L", "$",{ desc = "Use 'L' as '$'" })

--调整esc为jj 并且设置间隔时间避免
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {noremap = true})
vim.cmd("autocmd InsertEnter * set timeoutlen=150")
vim.cmd("autocmd InsertLeave * set timeoutlen=1000")

--括号匹配输入
vim.api.nvim_set_keymap("i", "(", "()<Left>", {noremap = true})
vim.api.nvim_set_keymap("i", "[", "[]<Left>", {noremap = true})
vim.api.nvim_set_keymap("i", "<", "<><Left>", {noremap = true})
vim.api.nvim_set_keymap("i", "{", "{}<Esc>i", {noremap = true})
vim.api.nvim_set_keymap("i", "'", "''<Left>", {noremap = true})
vim.api.nvim_set_keymap("i", "\"", "\"\"<Left>", {noremap = true})
