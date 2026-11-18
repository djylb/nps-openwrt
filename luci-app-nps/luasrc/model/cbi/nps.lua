local nps = require "luci.tools.nps"

local conf_file = nps.file()
local default_file = nps.conf_dir .. "/nps.conf.default"

m = Map("nps", translate("NPS Server"))
m.apply_on_parse = true
-- conf_changed is set when the page wrote the config file, which is not in
-- UCI and so starts no commit.
local conf_changed = false
function m.on_after_save(self)
	if conf_changed and luci.model.uci.cursor():get("nps", "@nps[0]", "enable") == "1" then
		luci.sys.call("/etc/init.d/nps restart >/dev/null 2>&1")
	end
end
function m.on_after_commit(self)
	local enabled = luci.model.uci.cursor():get("nps", "@nps[0]", "enable")
	luci.sys.call("/etc/init.d/nps " .. (enabled == "1" and "restart" or "stop") .. " >/dev/null 2>&1")
end

m:section(SimpleSection).template = "nps/nps_status"

s = m:section(TypedSection, "nps")
s.addremove = false
s.anonymous = true

s:tab("basic", translate("Basic Settings"))
s:tab("config", translate("Config File"))
s:tab("maintain", translate("Install and Update"))

enable = s:taboption("basic", Flag, "enable", translate("Enable"))
enable.rmempty = false
enable.default = "0"

note = s:taboption("basic", DummyValue, "_note", translate("Data"))
note.default = translate("Clients, tunnels and domains are managed in the NPS web panel; open it with the button above when NPS runs.")

conf = s:taboption("config", TextValue, "_conf", conf_file,
	translate("The file NPS reads. Saving writes it and restarts NPS; the previous version is kept as a .bak file."))
conf.rows = 30
conf.wrap = "off"
function conf.cfgvalue()
	return nps.read(conf_file) or nps.read(default_file) or ""
end
function conf.remove() end
function conf.write(self, section, value)
	value = (value or ""):gsub("\r\n", "\n")
	if value == (nps.read(conf_file) or "") then
		return
	end
	luci.sys.call(string.format("[ -f '%s' ] && cp -p '%s' '%s.bak'", conf_file, conf_file, conf_file))
	local f = io.open(conf_file, "w")
	if f then
		f:write(value)
		f:close()
	end
	conf_changed = true
end

update_button = s:taboption("maintain", Button, "_update", translate("Update NPS"), translate("Update NPS to the latest release and restart it"))
update_button.inputstyle = "apply"
function update_button.write()
	luci.sys.call("( /usr/bin/nps update && /etc/init.d/nps restart ) >/tmp/nps_update.log 2>&1 &")
end

install_button = s:taboption("maintain", Button, "_install", translate("Install NPS"), translate("Install or reinstall NPS with the install script"))
function install_button.write()
	luci.sys.call("( wget -qO- https://fastly.jsdelivr.net/gh/djylb/nps@master/install.sh | sh -s nps && /etc/init.d/nps restart ) >/tmp/nps_install.log 2>&1 &")
end

default_button = s:taboption("maintain", Button, "_default", translate("Default Config"),
	translate("Replace the config file with the default one shipped with NPS; the current one is kept as a .bak file."))
default_button.inputstyle = "reset"
function default_button.write(self, section)
	local def = nps.read(default_file)
	if not def then
		return
	end
	luci.sys.call(string.format("[ -f '%s' ] && cp -p '%s' '%s.bak'", conf_file, conf_file, conf_file))
	local f = io.open(conf_file, "w")
	if f then
		f:write(def)
		f:close()
	end
	conf_changed = true
end

home = s:taboption("maintain", DummyValue, "_home", translate("Project"))
home.rawhtml = true
home.default = '<a href="https://github.com/djylb/nps-openwrt" target="_blank" rel="noopener">github.com/djylb/nps-openwrt</a>'

return m
