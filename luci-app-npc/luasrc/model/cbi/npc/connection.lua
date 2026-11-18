local npc = require "luci.tools.npc"
local dsp = require "luci.dispatcher"
local sid = arg[1]

m = Map("npc", translate("NPS Client") .. " - " .. translate("Connection") .. " " .. (sid or ""))
m.redirect = dsp.build_url("admin", "services", "npc")
m.apply_on_parse = true
function m.on_after_commit(self)
	luci.sys.call("/etc/init.d/npc restart >/dev/null 2>&1")
end
if not sid or m.uci:get("npc", sid) ~= "connection" then
	luci.http.redirect(m.redirect)
	return
end

s = m:section(NamedSection, sid, "connection")
s.anonymous = true
s.addremove = false

en = s:option(Flag, "enabled", translate("Enable"))
en.rmempty = false
en.default = "1"

link = s:option(TextValue, "link", translate("Launch Link"),
	translate("Copy \"Launch link\" from the NPS web page \"Launch command\". Also accepted: @/path/to/file, an http(s) URL or base64. Line breaks and spaces are removed on save."))
link.rows = 6
link.wrap = "soft"
link.rmempty = false
function link.validate(self, value)
	value = (value or ""):gsub("%s+", "")
	if value == "" then
		return nil, translate("Launch link is empty")
	end
	return value
end
function link.write(self, section, value)
	AbstractValue.write(self, section, (value or ""):gsub("%s+", ""))
end

info = s:option(DummyValue, "_info", translate("Server"))
function info.cfgvalue(self, section)
	local hp, carrier, paths = npc.server(self.map:get(section, "link"))
	if not hp then return "-" end
	return string.format("%s · %s", hp, paths > 1 and string.format("%s +%d", carrier, paths - 1) or carrier)
end

return m
