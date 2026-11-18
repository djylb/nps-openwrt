-- Helpers of the NPS page: which config file nps reads, and the address of
-- its web panel.
local fs = require "nixio.fs"

local M = {}

M.conf_dir = "/etc/nps/conf"

-- The names nps tries in its conf directory, in its order.
local names = { "nps.conf", "nps.ini", "nps.yaml", "nps.yml", "nps.json" }

-- file returns the config file nps reads: the first that exists, else
-- nps.conf.
function M.file()
	for _, n in ipairs(names) do
		local p = M.conf_dir .. "/" .. n
		if fs.access(p) then
			return p
		end
	end
	return M.conf_dir .. "/nps.conf"
end

function M.read(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local s = f:read("*a")
	f:close()
	return s
end

-- panel returns the scheme, port and base path of the web panel from the
-- key=value config, or nil when it is off or the file is not of that form.
function M.panel(text)
	if not text then
		return nil
	end
	local kv = {}
	for line in text:gmatch("[^\r\n]+") do
		local k, v = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
		if k and not line:match("^%s*[#;]") then
			kv[k] = v
		end
	end
	local port = tonumber(kv.web_port or "")
	if not port or port == 0 then
		return nil
	end
	local tls = kv.web_open_ssl == "true"
	return tls and "https" or "http", port, kv.web_base_url or ""
end

return M
