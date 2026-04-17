local M = {}

local cached_proxy_url = nil
local parsed_proxy_url = false

local function running_under_proxychains()
	local ld_preload = vim.env.LD_PRELOAD
	return ld_preload and ld_preload:match("proxychains") ~= nil
end

local function default_proxychains_conf()
	local home = vim.env.HOME
	if not home or home == "" then
		return nil
	end
	return home .. "/.proxychains/proxychains.conf"
end

local function get_proxychains_conf()
	local conf = vim.env.PROXYCHAINS_CONF
	if conf and conf ~= "" then
		conf = vim.fn.expand(conf)
		if vim.fn.isdirectory(conf) == 1 then
			return conf .. "/proxychains.conf"
		end
		return conf
	end
	return default_proxychains_conf()
end

local function parse_proxy_url()
	if parsed_proxy_url then
		return cached_proxy_url
	end
	parsed_proxy_url = true

	local conf = get_proxychains_conf()
	if not conf or vim.fn.filereadable(conf) ~= 1 then
		return nil
	end

	local schemes = {
		socks5 = "socks5h",
		socks4 = "socks4a",
		http = "http",
	}

	local in_proxy_list = false
	for _, line in ipairs(vim.fn.readfile(conf)) do
		local trimmed = vim.trim(line)
		if trimmed == "" or vim.startswith(trimmed, "#") then
			goto continue
		end

		if trimmed == "[ProxyList]" then
			in_proxy_list = true
			goto continue
		end

		if not in_proxy_list then
			goto continue
		end

		local fields = vim.split(trimmed, "%s+", { trimempty = true })
		local scheme = schemes[fields[1]]
		local host = fields[2]
		local port = fields[3]

		if scheme and host and port then
			cached_proxy_url = string.format("%s://%s:%s", scheme, host, port)
			return cached_proxy_url
		end

		::continue::
	end

	return nil
end

local function set_env_if_missing(name, value)
	if not value or value == "" then
		return
	end
	if vim.env[name] and vim.env[name] ~= "" then
		return
	end
	vim.env[name] = value
end

function M.get_proxy_url()
	return parse_proxy_url()
end

function M.setup_env()
	if running_under_proxychains() then
		return
	end

	local proxy = M.get_proxy_url()
	if not proxy then
		return
	end

	for _, name in ipairs({
		"ALL_PROXY",
		"all_proxy",
		"HTTPS_PROXY",
		"https_proxy",
		"HTTP_PROXY",
		"http_proxy",
	}) do
		set_env_if_missing(name, proxy)
	end
end

function M.setup_treesitter()
	if running_under_proxychains() then
		return
	end

	local proxy = M.get_proxy_url()
	if not proxy then
		return
	end

	local ok, install = pcall(require, "nvim-treesitter.install")
	if not ok then
		return
	end

	install.prefer_git = false
	install.command_extra_args = install.command_extra_args or {}
	install.command_extra_args.curl = { "--proxy", proxy }
end

function M.setup()
	M.setup_env()
	M.setup_treesitter()
end

return M
