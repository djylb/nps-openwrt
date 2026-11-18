local dsp = require "luci.dispatcher"
local sid = arg[1]

m = Map("npc", translate("NPS Client") .. " - " .. translate("Local Access") .. " " .. (sid or ""))
m.redirect = dsp.build_url("admin", "services", "npc")
m.apply_on_parse = true
function m.on_after_commit(self)
	luci.sys.call("/etc/init.d/npc restart >/dev/null 2>&1")
end
if not sid or m.uci:get("npc", sid) ~= "access" then
	luci.http.redirect(m.redirect)
	return
end

s = m:section(NamedSection, sid, "access")
s.anonymous = true
s.addremove = false

en = s:option(Flag, "enabled", translate("Enable"))
en.rmempty = false
en.default = "1"

link = s:option(TextValue, "link", translate("Access Link"),
	translate("Copy \"Local access (-L)\" from the NPS web page \"Launch command\", e.g. tcp://0.0.0.0:2000?access=KEY&target=192.168.1.10:22&via=home"))
link.rows = 3
link.wrap = "soft"
link.rmempty = false
function link.validate(self, value)
	value = (value or ""):gsub("%s+", "")
	if not value:match("^[%w_]+://") then
		return nil, translate("Access link must start with a type such as tcp://")
	end
	return value
end
function link.write(self, section, value)
	AbstractValue.write(self, section, (value or ""):gsub("%s+", ""))
end

return m
