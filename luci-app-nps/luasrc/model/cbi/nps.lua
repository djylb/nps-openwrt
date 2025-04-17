m = Map("nps", translate("NPS Server"), translate("Nps is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."))

m:section(SimpleSection).template = "nps/nps_status"

s = m:section(TypedSection, "nps")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.rmempty = false
enable.default = "0"

local conf_file_path = "/etc/nps/conf/nps.conf"
text_value = server_s:option(TextValue, "nps_conf", translate("NPS Configuration"))
text_value.rows = 20
text_value.wrap = "off"
local conf_file = io.open(conf_file_path, "r")
if conf_file then
    text_value.default = conf_file:read("*a")
    conf_file:close()
else
    local default_conf_path = "/etc/nps/conf/nps.conf.default"
    local default_conf_file = io.open(default_conf_path, "r")
    if default_conf_file then
        text_value.default = default_conf_file:read("*a")
        default_conf_file:close()
    else
        luci.sys.call("wget -O /etc/nps/conf/nps.conf.default https://raw.githubusercontent.com/djylb/nps/refs/heads/master/conf/nps.conf")
        local new_conf_file = io.open(default_conf_path, "r")
        if new_conf_file then
            text_value.default = new_conf_file:read("*a")
            new_conf_file:close()
        end
    end
end

function text_value.write(self, section, value)
    local conf_file = io.open(conf_file_path, "w")
    if conf_file then
        conf_file:write(value)
        conf_file:close()

        local is_running = luci.sys.call("pgrep -x nps > /dev/null") == 0
        if is_running then
            luci.sys.call("/etc/init.d/nps restart")
        end
    end
end

update_button = s:option(Button, "update_button", translate("Update NPS"))
update_button.modal = false
function update_button.write(self, section, value)
    luci.http.status(200)
    luci.http.redirect(luci.dispatcher.build_url("admin", "services", "nps"))
    luci.sys.call("/usr/bin/nps update")
    luci.sys.call("mv /usr/local/bin/nps /usr/bin/nps")
    luci.sys.call("mv /usr/local/bin/nps-update /usr/bin/nps-update")
    local is_running = luci.sys.call("pgrep -x nps > /dev/null") == 0
    if is_running then
        luci.sys.call("/etc/init.d/nps restart")
    end
end

default_button = s:option(Button, "default_button", translate("Default Config"))
default_button.modal = false
function default_button.write(self, section, value)
    local default_conf_file = io.open("/etc/nps/conf/nps.conf.default", "r")
    if default_conf_file then
        text_value.default = default_conf_file:read("*a")
        default_conf_file:close()
    end
end

github_button = s:option(Button, "github_button", "Github", "https://github.com/djylb/nps-openwrt")
github_button.modal = false
function github_button.write(self, section, value)
    luci.http.status(200)
    luci.http.redirect("https://github.com/djylb/nps-openwrt")
end

return m
