module("luci.controller.nps", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/nps") then
		return
	end

	entry({"admin", "services", "nps"}, cbi("nps"), _("NPS Server"), 100).dependent = true
	entry({"admin", "services", "nps", "status"}, call("act_status")).leaf = true
end

function act_status()
	local fs = require "nixio.fs"
	local e = {}

	if not fs.access("/usr/bin/nps") then
		e.installed    = false
		e.running      = false
		e.version      = ""
		e.core_version = ""
	else
		e.installed   = true
		e.running      = (luci.sys.call("pgrep nps > /dev/null") == 0)
		local ver_out  = luci.sys.exec("/usr/bin/nps -version 2>/dev/null")
		e.version      = ver_out:match("Version:%s*([v%d%.%-]+)")      or ""
		e.core_version = ver_out:match("Core version:%s*([v%d%.%-]+)") or ""
	end

	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
