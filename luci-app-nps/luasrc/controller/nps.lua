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
	local util = require "luci.util"
	local nps = require "luci.tools.nps"
	local e = { installed = fs.access("/usr/bin/nps") and true or false, running = false, version = "" }

	if e.installed then
		local out = luci.sys.exec("/usr/bin/nps -version 2>/dev/null")
		e.version = out:match("Version:%s*([v%d%.%-]+)") or ""
	end

	local st = util.ubus("service", "list", { name = "nps" })
	local inst = st and st.nps and st.nps.instances and st.nps.instances.instance1
	if inst then
		e.running = inst.running and true or false
		e.exit_code = inst.exit_code
	end

	local scheme, port, base = nps.panel(nps.read(nps.file()))
	if scheme then
		e.panel = { scheme = scheme, port = port, base = base }
	end

	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
