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

-- Quick import: a pasted npc command line, or links one per line, becomes
-- connection and access sections.
local function shell_words(text)
	local words, cur, i, n, quote = {}, nil, 1, #text, nil
	while i <= n do
		local ch = text:sub(i, i)
		if quote then
			if ch == quote then
				quote = nil
			elseif ch == "\\" and quote == '"' and i < n then
				i = i + 1
				cur = cur .. text:sub(i, i)
			else
				cur = cur .. ch
			end
		elseif ch == '"' or ch == "'" then
			quote, cur = ch, cur or ""
		elseif ch == "\\" and i < n then
			i = i + 1
			local nx = text:sub(i, i)
			if nx ~= "\n" then cur = (cur or "") .. nx end
		elseif ch:match("%s") then
			if cur then words[#words + 1], cur = cur, nil end
		else
			cur = (cur or "") .. ch
		end
		i = i + 1
	end
	if cur then words[#words + 1] = cur end
	return words
end

local access_schemes = { tcp = true, udp = true, tcp_udp = true, mixed = true, socks5 = true, http = true, transparent = true }

local function parse_import(text)
	local conns, access = {}, {}
	local words = shell_words(text or "")
	local i = 1
	while i <= #words do
		local w = words[i]
		local flag, val = w:match("^%-%-?([%w_]+)=(.*)$")
		if not flag and w:match("^%-%-?[%w_]+$") and words[i + 1] then
			flag, val = w:gsub("^%-+", ""), words[i + 1]
			if flag == "launch" or flag == "L" or flag == "local" then i = i + 1 else flag = nil end
		end
		if flag == "launch" then
			conns[#conns + 1] = val
		elseif flag == "L" or flag == "local" then
			access[#access + 1] = val
		elseif not flag then
			local scheme = w:match("^([%w_]+)://")
			if scheme == "npc" then
				conns[#conns + 1] = w
			elseif scheme and access_schemes[scheme] then
				access[#access + 1] = w
			end
		end
		i = i + 1
	end
	return conns, access
end

local function section_name(uci, link, prefix)
	local name = link:match("#([^#]+)$")
	name = name and name:gsub("[^%w_]", "_") or nil
	if not name or name == "" or uci:get("npc", name) then
		local n = 1
		repeat
			name, n = prefix .. n, n + 1
		until not uci:get("npc", name)
	end
	return name
end

imp = s:taboption("basic", TextValue, "_import", translate("Quick Import"),
	translate("Paste the command or the links copied from the NPS web page \"Launch command\"; on save every -launch becomes a connection and every -L a local access below; links already present are skipped."))
imp.rows = 3
imp.wrap = "soft"
imp.placeholder = "./npc -launch=\"npc://...\" -L=\"tcp://...\""
function imp.cfgvalue() return "" end
function imp.remove() end
function imp.write(self, section, value)
	local uci = self.map.uci
	local conns, access = parse_import(value)
	local seen = {}
	uci:foreach("npc", "connection", function(sec) seen[(sec.link or "")] = true end)
	uci:foreach("npc", "access", function(sec) seen[(sec.link or "")] = true end)
	for _, l in ipairs(conns) do
		l = l:gsub("%s+", "")
		local bare = l:gsub("#[^#]*$", "")
		if not seen[l] and not seen[bare] then
			local name = section_name(uci, l, "conn")
			uci:section("npc", "connection", name, { enabled = "1", link = l:match("^npc://") and bare or l })
			seen[l] = true
		end
	end
	for _, l in ipairs(access) do
		l = l:gsub("%s+", "")
		if not seen[l] then
			uci:section("npc", "access", section_name(uci, l, "access"), { enabled = "1", link = l })
			seen[l] = true
		end
	end
end

-- Connections: one section per -launch
c = m:section(TypedSection, "connection", translate("Connections"),
	translate("Each connection runs independently inside the same NPC process. The name is used as the connection name (#name) in logs and by via= of local access. Copy the \"Launch link\" from the NPS web page \"Launch command\", or use Quick Import above; line breaks and spaces in it are removed on save."))
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
