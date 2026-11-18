m = Map("npc", translate("NPS Client"), translate("NPS is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."))
m.apply_on_parse = true
function m.on_after_commit(self)
	local enabled = luci.model.uci.cursor():get("npc", "@npc[0]", "enable")
	if enabled == "1" then
		luci.sys.call("/etc/init.d/npc restart >/dev/null 2>&1")
	else
		luci.sys.call("/etc/init.d/npc stop >/dev/null 2>&1")
	end
end

m:section(SimpleSection).template = "npc/npc_status"

local function squash_write(self, section, value)
	value = (value or ""):gsub("%s+", "")
	AbstractValue.write(self, section, value)
end

-- Global settings
s = m:section(TypedSection, "npc", translate("Global Settings"))
s.addremove = false
s.anonymous = true

s:tab("basic", translate("Basic Settings"))
s:tab("advanced", translate("Advanced Settings"))
s:tab("legacy", translate("Legacy Connection"))

enable = s:taboption("basic", Flag, "enable", translate("Enable"))
enable.rmempty = false
enable.default = "0"

dns = s:taboption("basic", Value, "dns", translate("DNS Server"), translate("e.g. 8.8.8.8"))
dns.default = ""

log_level = s:taboption("basic", ListValue, "log_level", translate("Log Level"),
	translate("Logs go to the system log (Status > System Log) when a level is chosen."))
log_level:value("", translate("Off"))
log_level:value("error")
log_level:value("warn")
log_level:value("info")
log_level:value("debug")
log_level:value("trace")

update_button = s:taboption("basic", Button, "update_button", translate("Update NPC"), translate("Click to update to the latest version"))
update_button.modal = false
function update_button.write(self, section, value)
	luci.http.redirect(luci.dispatcher.build_url("admin", "services", "npc"))
	luci.sys.call("( /usr/bin/npc update -dns_server= && /etc/init.d/npc restart ) >/tmp/npc_update.log 2>&1 &")
end

install_button = s:taboption("basic", Button, "install_button", translate("Install NPC"), translate("Click to install or update NPC via script"))
install_button.modal = false
function install_button.write(self, section, value)
	luci.http.redirect(luci.dispatcher.build_url("admin", "services", "npc"))
	luci.sys.call("( wget -qO- https://fastly.jsdelivr.net/gh/djylb/nps@master/install.sh | sh -s npc && /etc/init.d/npc restart ) >/tmp/npc_install.log 2>&1 &")
end

github_button = s:taboption("basic", Button, "github_button", "Github", "https://github.com/djylb/nps-openwrt")
github_button.modal = false
function github_button.write(self, section, value)
	luci.http.status(200)
	luci.http.redirect("https://github.com/djylb/nps-openwrt")
end

extra_args = s:taboption("advanced", TextValue, "extra_args", translate("Extra Arguments"),
	translate("Additional NPC arguments in shell syntax, line breaks allowed; quote values containing & ? | ; e.g. -pipes=multi -log=stdout"))
extra_args.rows = 3
extra_args.wrap = "soft"
extra_args.rmempty = true

config_file = s:taboption("advanced", Value, "config_file", translate("Config File"),
	translate("Optional INI config file path (-config). Ignored by NPC when connections are given."))
config_file.placeholder = "/etc/nps/conf/npc.conf"

legacy_note = s:taboption("legacy", DummyValue, "_legacy_note")
legacy_note.default = translate("Deprecated in NPC 0.35 (-server/-vkey/-type). Used only when no connection or config file is set, because NPC refuses -server/-vkey together with -launch.")

server = s:taboption("legacy", Value, "server_addr", translate("Server Address"), translate("(host:port) e.g. xxx.com:8024,yyy.com:8025..."))

vkey = s:taboption("legacy", Value, "vkey", translate("vkey"), translate("(vkey) e.g. vkey1,vkey2..."))
vkey.password = true

protocol = s:taboption("legacy", Value, "protocol", translate("Protocol Type"), translate("(tls|quic|wss|tcp) e.g. tls,quic..."))
protocol.default = "tls"

-- Connections: one section per -launch
c = m:section(TypedSection, "connection", translate("Connections"),
	translate("Each connection runs independently inside the same NPC process. The name is used as the connection name (#name) in logs and by via= of local access. Copy the link from the NPS web page \"Launch command\"; line breaks and spaces in it are removed on save."))
c.addremove = true
c.anonymous = false

cen = c:option(Flag, "enabled", translate("Enable"))
cen.rmempty = false
cen.default = "1"

link = c:option(TextValue, "link", translate("Launch Link"),
	translate("npc:// link, @/path/to/file, http(s) URL or base64"))
link.rows = 4
link.wrap = "soft"
link.rmempty = false
link.write = squash_write
function link.validate(self, value)
	value = (value or ""):gsub("%s+", "")
	if value == "" then
		return nil, translate("Launch link is empty")
	end
	return value
end

-- Local point-to-point access: one section per -L
a = m:section(TypedSection, "access", translate("Local Access"),
	translate("Optional point-to-point access listeners on this router (-L). e.g. tcp://0.0.0.0:2000?access=KEY&target=192.168.1.10:22&via=home"))
a.addremove = true
a.anonymous = false

aen = a:option(Flag, "enabled", translate("Enable"))
aen.rmempty = false
aen.default = "1"

alink = a:option(TextValue, "link", translate("Access Link"))
alink.rows = 2
alink.wrap = "soft"
alink.rmempty = false
alink.write = squash_write

return m
