local M = {}

function M.check_load_lazy()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		-- stylua: ignore
		local install = vim.fn.confirm(
			'lazy plugin not found, install now?', '&Yes\n&No', 2)

		if install == 1 then
			M.bootstrap_lazy(lazypath)
		end
	end

	if vim.loop.fs_stat(lazypath) then
		vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
		M.load_lazy()
	end
end

function M.bootstrap_lazy(path)
	vim.notify("bootstrap lazy.nvim ..", vim.log.levels.INFO)
	-- stylua: ignore
	vim.fn.system({
		'git', 'clone', '--filter=blob:none', '--branch=stable',
		'https://github.com/folke/lazy.nvim.git', path })
end

-- Configure lazy.nvim
function M.load_lazy()
	require("lazy").setup({
		root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
		defaults = {
			lazy = true, -- should plugins be lazy-loaded?
			version = false, -- version = "*", -- enable this to try installing the latest stable versions of plugins
			-- default `cond` you can use to globally disable a lot of plugins
			-- when running inside vscode for example
			cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
		},
		spec = {
			{
				import = "plugins",
			},
		},
		lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- lockfile generated after running update.

		install = {
			-- NOTE: set to false for no auto install on startup
			missing = true,
			colorscheme = { "tokyonight" },
		},
		ui = {
			-- a number <1 is a percentage., >1 is a fixed size
			size = { width = 0.8, height = 0.8 },
			wrap = true, -- wrap the lines in the ui
			-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
			border = "none",
			title = nil, ---@type string only works when border is not "none"
			title_pos = "center", ---@type "center" | "left" | "right"
			icons = {
				cmd = " ",
				config = "",
				event = "",
				ft = " ",
				init = " ",
				import = " ",
				keys = " ",
				lazy = "󰒲 ",
				loaded = "●",
				not_loaded = "○",
				plugin = " ",
				runtime = " ",
				source = " ",
				start = "",
				task = "✔ ",
				list = {
					"●",
					"➜",
					"★",
					"‒",
				},
			},
			-- leave nil, to automatically select a browser depending on your OS.
			-- If you want to use a specific browser, you can define it here
			browser = nil, ---@type string?
			throttle = 20, -- how frequently should the ui process render events
			-- custom_keys = {
			-- 	-- you can define custom key maps here.
			-- 	-- To disable one of the defaults, set it to false
			--
			-- 	-- open lazygit log
			-- 	["<localleader>l"] = function(plugin)
			-- 		require("lazy.util").float_term({ "lazygit", "log" }, {
			-- 			cwd = plugin.dir,
			-- 		})
			-- 	end,
			--
			-- 	-- open a terminal for the plugin dir
			-- 	["<localleader>t"] = function(plugin)
			-- 		require("lazy.util").float_term(nil, {
			-- 			cwd = plugin.dir,
			-- 		})
			-- 	end,
			-- },
		},
		checker = {
			-- automatically check for plugin updates
			enabled = false,
			concurrency = nil, ---@type number? set to 1 to check for updates very slowly
			notify = true, -- get a notification when new updates are found
			frequency = 3600 * 24 * 7, -- check for updates every week
		},
		change_detection = {
			-- automatically check for config file changes and reload the ui
			enabled = true,
			notify = true, -- get a notification when changes are found
		},
		performance = {
			cache = {
				enabled = true,
			},
			rtp = {
				paths = { "/usr/share/vim/vimfiles" },
				-- disable some rtp plugins
				disabled_plugins = {
					"2html_plugin",
					"getscript",
					"getscriptPlugin",
					"gzip",
					"logipat",
					"netrw",
					"netrwPlugin",
					"netrwSettings",
					"netrwFileHandlers",
					"matchit",
					"tar",
					"tarPlugin",
					"rrhelper",
					"spellfile_plugin",
					"vimball",
					"vimballPlugin",
					"zip",
					"zipPlugin",
					"tutor",
					"rplugin",
					"synmenu",
					"optwin",
					"compiler",
					"bugreport",
					"ftplugin",
				},
			},
		},
	})
end

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return M
