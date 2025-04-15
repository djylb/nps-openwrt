m = Map("npc", translate("NPS Client"), translate("Nps is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."))

m:section(SimpleSection).template = "npc/npc_status"

s = m:section(TypedSection,"npc")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.rmempty = false
enable.default = "0"

server = s:option(Value, "server_addr", translate("Server Address"), translate("IP address or Domain Name"))
server.rmempty = false

port = s:option(Value, "server_port", translate("Port"))
port.datatype = "port"
port.default = "8024"
port.rmempty = false

vkey = s:option(Value, "vkey", translate("vkey"))
vkey.password = true
vkey.rmempty = false

protocol = s:option(ListValue, "protocol", translate("Protocol Type"))
protocol.default = "tcp"
protocol:value("tcp", translate("TCP Protocol"))
protocol:value("kcp", translate("KCP Protocol"))

tls_enable = s:option(Flag, "tls_enable", translate("Enable TLS"), translate("Enable TLS requires server support, only works in TCP mode, helps prevent traffic fingerprinting."))
tls_enable.default = "0"
tls_enable.rmempty = false

max_conn = s:option(Value, "max_conn", translate("Max Connection Limit"), translate("Maximum number of connections (Not necessary)"))
max_conn.optional = true
max_conn.rmempty = true

rate_limit = s:option(Value, "rate_limit", translate("Rate Limit"), translate("Client rate limit (Not necessary)"))
rate_limit.optional = true
rate_limit.rmempty = true

flow_limit = s:option(Value, "flow_limit", translate("Flow Limit"), translate("Client flow limit (Not necessary)"))
flow_limit.optional = true
flow_limit.rmempty = true

compress = s:option(Flag, "compress", translate("Enable Compression"), translate("The contents will be compressed to speed up the traffic forwarding speed, but this will consume some additional cpu resources."))
compress.default = "0"
compress.rmempty = false

crypt = s:option(Flag, "crypt", translate("Enable Encryption"), translate("Encrypted the communication between Npc and Nps, will effectively prevent the traffic intercepted."))
crypt.default = "0"
crypt.rmempty = false

update_button = s:option(Button, "update_button", translate("Update NPC"))
update_button.modal = false
function update_button.write(self, section, value)
    luci.sys.call("/usr/bin/npc update")
    luci.sys.call("mv /usr/local/bin/npc /usr/bin/npc")
    luci.sys.call("mv /usr/local/bin/npc-update /usr/bin/npc-update")
end

return m
