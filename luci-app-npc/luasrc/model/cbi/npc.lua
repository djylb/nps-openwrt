m = Map("npc", translate("NPS Client"), translate("Nps is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."))
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

s = m:section(TypedSection,"npc")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.rmempty = false
enable.default = "0"

server = s:option(Value, "server_addr", translate("Server Address"), translate("(host:port) e.g. xxx.com:8024,yyy.com:8025..."))
server.rmempty = false

vkey = s:option(Value, "vkey", translate("vkey"), translate("(vkey) e.g. vkey1,vkey2..."))
vkey.password = true
vkey.rmempty = false

protocol = s:option(Value, "protocol", translate("Protocol Type"), translate("(tcp|tls|kcp) e.g. tcp,tls..."))
protocol.default = "tcp"

dns = s:option(Value, "dns", translate("DNS Server"), translate("e.g. 8.8.8.8"))
dns.default = ""

update_button = s:option(Button, "update_button", translate("Update NPC"), translate("Click to update to the latest version"))
update_button.modal = false
function update_button.write(self, section, value)
    luci.http.redirect(luci.dispatcher.build_url("admin", "services", "npc"))
    luci.sys.call("( /usr/bin/npc update && /etc/init.d/npc restart ) >/tmp/npc_update.log 2>&1 &")
end

github_button = s:option(Button, "github_button", "Github", "https://github.com/djylb/nps-openwrt")
github_button.modal = false
function github_button.write(self, section, value)
    luci.http.status(200)
    luci.http.redirect("https://github.com/djylb/nps-openwrt")
end

return m
