module("luci.controller.npc",package.seeall)

function index()
	if not nixio.fs.access("/etc/config/npc") then
		return
	end

	entry({"admin", "services", "npc"}, cbi("npc"), _("NPS Client"), 99).dependent = true
	entry({"admin", "services", "npc", "status"}, call("act_status")).leaf = true
	entry({"admin", "services", "npc", "connection"}, cbi("npc/connection")).leaf = true
	entry({"admin", "services", "npc", "access"}, cbi("npc/access")).leaf = true
end

local function mask(arg)
	arg = arg:gsub("(npc://)[^@/?#]+@", "%1***@")
	arg = arg:gsub("(admit_key=)[^&;#|]+", "%1***")
	arg = arg:gsub("(access=)[^&;#|]+", "%1***")
	arg = arg:gsub("^(%-%-?vkey=).*", "%1***")
	arg = arg:gsub("^(%-%-?k=).*", "%1***")
	return arg
end

function act_status()
	local fs = require "nixio.fs"
	local util = require "luci.util"
	local e = {}

	e.installed = fs.access("/usr/bin/npc") and true or false
	e.running = false
	e.version = ""
	if e.installed then
		local ver_out = luci.sys.exec("/usr/bin/npc -version 2>/dev/null")
		e.version = ver_out:match("Version:%s*([v%d%.%-]+)") or ""
	end

	local st = util.ubus("service", "list", { name = "npc" })
	local inst = st and st.npc and st.npc.instances and st.npc.instances.instance1
	if inst then
		e.running = inst.running and true or false
		e.exit_code = inst.exit_code
		if type(inst.command) == "table" then
			local args = {}
			for i, a in ipairs(inst.command) do
				args[i] = mask(tostring(a))
			end
			e.command = table.concat(args, "\n  ")
		end
	end

	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
