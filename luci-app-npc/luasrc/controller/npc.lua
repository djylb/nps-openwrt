module("luci.controller.npc",package.seeall)

function index()
	if not nixio.fs.access("/etc/config/npc") then
		return
	end

	entry({"admin", "services", "npc"}, cbi("npc"), _("NPS Client"), 99).dependent = true
	entry({"admin", "services", "npc", "status"}, call("act_status")).leaf = true
end

function act_status()
	local e = {}
	e.running = luci.sys.call("pgrep npc > /dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

function act_update()
    luci.sys.call("/usr/bin/npc update")
    luci.sys.call("mv /usr/local/bin/npc /usr/bin/npc")
    luci.sys.call("mv /usr/local/bin/npc-update /usr/bin/npc-update")
    
    luci.http.status(200)
    luci.http.write("Done")
end
