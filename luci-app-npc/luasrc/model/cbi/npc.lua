local npc = require "luci.tools.npc"
local dsp = require "luci.dispatcher"

m = Map("npc", translate("NPS Client"))
m.apply_on_parse = true
function m.on_after_commit(self)
	local enabled = luci.model.uci.cursor():get("npc", "@npc[0]", "enable")
	luci.sys.call("/etc/init.d/npc " .. (enabled == "1" and "restart" or "stop") .. " >/dev/null 2>&1")
end

m:section(SimpleSection).template = "npc/npc_status"

-- Settings of the whole client
s = m:section(TypedSection, "npc")
s.addremove = false
s.anonymous = true

s:tab("basic", translate("Basic Settings"))
s:tab("advanced", translate("Advanced Settings"))
s:tab("maintain", translate("Install and Update"))

enable = s:taboption("basic", Flag, "enable", translate("Enable"))
enable.rmempty = false
enable.default = "0"

imp = s:taboption("basic", TextValue, "_import", translate("Quick Import"),
	translate("Paste the command or the links copied from the NPS web page \"Launch command\" and save: every -launch becomes a connection and every -L a local access below; links already present are skipped."))
imp.rows = 3
imp.wrap = "soft"
imp.placeholder = "npc -launch=\"npc://...\" -L=\"tcp://...\""
function imp.cfgvalue() return "" end
function imp.remove() end
function imp.write(self, section, value)
	npc.import(self.map.uci, value)
end

log_level = s:taboption("advanced", ListValue, "log_level", translate("Log Level"),
	translate("Logs go to the system log (Status > System Log) when a level is chosen."))
log_level:value("", translate("Off"))
log_level:value("error")
log_level:value("warn")
log_level:value("info")
log_level:value("debug")
log_level:value("trace")

dns = s:taboption("advanced", Value, "dns", translate("DNS Server"), translate("e.g. 8.8.8.8"))

extra_args = s:taboption("advanced", TextValue, "extra_args", translate("Extra Arguments"),
	translate("Additional NPC arguments in shell syntax, line breaks allowed; quote values containing & ? | ; e.g. -pipes=multi"))
extra_args.rows = 2
extra_args.wrap = "soft"

config_file = s:taboption("advanced", Value, "config_file", translate("Config File"),
	translate("Optional INI config file path (-config), for setups without connections."))
config_file.placeholder = "/etc/nps/conf/npc.conf"

update_button = s:taboption("maintain", Button, "_update", translate("Update NPC"), translate("Update NPC to the latest release and restart it"))
update_button.inputstyle = "apply"
function update_button.write()
	luci.sys.call("( /usr/bin/npc update -dns_server= && /etc/init.d/npc restart ) >/tmp/npc_update.log 2>&1 &")
end

install_button = s:taboption("maintain", Button, "_install", translate("Install NPC"), translate("Install or reinstall NPC with the install script"))
function install_button.write()
	luci.sys.call("( wget -qO- https://fastly.jsdelivr.net/gh/djylb/nps@master/install.sh | sh -s npc && /etc/init.d/npc restart ) >/tmp/npc_install.log 2>&1 &")
end

home = s:taboption("maintain", DummyValue, "_home", translate("Project"))
home.rawhtml = true
home.default = '<a href="https://github.com/djylb/nps-openwrt" target="_blank" rel="noopener">github.com/djylb/nps-openwrt</a>'

-- Connections: one -launch each
c = m:section(TypedSection, "connection", translate("Connections"),
	translate("Each connection is one server profile of the NPS web page \"Launch command\"; all run in the same NPC process. Add one with Quick Import, or add a name here and paste its launch link."))
c.template = "cbi/tblsection"
c.addremove = true
c.anonymous = false
c.extedit = dsp.build_url("admin", "services", "npc", "connection", "%s")

cen = c:option(Flag, "enabled", translate("Enable"))
cen.rmempty = false
cen.default = "1"

csrv = c:option(DummyValue, "_server", translate("Server"))
function csrv.cfgvalue(self, section)
	local hp = npc.server(self.map:get(section, "link"))
	return hp or translate("(not an npc:// link)")
end

ccar = c:option(DummyValue, "_carrier", translate("Carrier"))
function ccar.cfgvalue(self, section)
	local _, carrier, paths = npc.server(self.map:get(section, "link"))
	if not carrier then return "-" end
	return paths > 1 and string.format("%s +%d", carrier, paths - 1) or carrier
end

-- Local access: one -L each
a = m:section(TypedSection, "access", translate("Local Access"),
	translate("Point-to-point access listeners on this router (-L), from the same NPS web page."))
a.template = "cbi/tblsection"
a.addremove = true
a.anonymous = false
a.extedit = dsp.build_url("admin", "services", "npc", "access", "%s")

aen = a:option(Flag, "enabled", translate("Enable"))
aen.rmempty = false
aen.default = "1"

alisten = a:option(DummyValue, "_listen", translate("Listen"))
function alisten.cfgvalue(self, section)
	return (npc.access(self.map:get(section, "link")))
end

atarget = a:option(DummyValue, "_target", translate("Target"))
function atarget.cfgvalue(self, section)
	local _, target, via = npc.access(self.map:get(section, "link"))
	if via ~= "" then
		target = (target ~= "" and target .. " " or "") .. "(" .. via .. ")"
	end
	return target ~= "" and target or "-"
end

return m
