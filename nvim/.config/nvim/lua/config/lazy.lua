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

-- Configure lazy.nvim
function M.load_lazy()
	require("lazy").setup({
		spec = {
			{
				import = "plugins",
			},
		},

		-- directory where plugins will be installed
		root = vim.fn.stdpath("data") .. "/lazy",
		lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",

		defaults = { lazy = true, version = false }, -- always use the latest git commit
		checker = {
			-- automatically check for plugin updates
			enabled = false,
			concurrency = nil, ---@type number? set to 1 to check for updates very slowly
			notify = true, -- get a notification when new updates are found
			frequency = 3600 * 24 * 7, -- check for updates every week
		},
		install = {
			-- NOTE: set to false for no auto install on startup
			missing = true,
			colorscheme = { "tokyonight" },
		},

		performance = {
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
return M
