m = Map("nps", translate("NPS Server"), translate("Nps is a fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet."))
m.apply_on_parse = true
function m.on_after_commit(self)
	local enabled = luci.model.uci.cursor():get("nps", "@nps[0]", "enable")
	if enabled == "1" then
		luci.sys.call("/etc/init.d/nps restart >/dev/null 2>&1")
	else
		luci.sys.call("/etc/init.d/nps stop >/dev/null 2>&1")
	end
end

m:section(SimpleSection).template = "nps/nps_status"

s = m:section(TypedSection, "nps")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.rmempty = false
enable.default = "0"

local conf_file_path = "/etc/nps/conf/nps.conf"
text_value = s:option(TextValue, "nps_conf", translate("NPS Configuration"))
text_value.rows = 40
text_value.size = 80
text_value.wrap = "soft"

function text_value.cfgvalue(self, section)
    local conf_file = io.open(conf_file_path, "r")
    if conf_file then
        local content = conf_file:read("*a")
        conf_file:close()
        return content
    else
        local default_conf_path = "/etc/nps/conf/nps.conf.default"
        local default_conf_file = io.open(default_conf_path, "r")
        if default_conf_file then
            local default_content = default_conf_file:read("*a")
            default_conf_file:close()
            return default_content
        else
            return ""
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

update_button = s:option(Button, "update_button", translate("Update NPS"), translate("Click to update to the latest version"))
update_button.modal = false
function update_button.write(self, section, value)
    luci.http.redirect(luci.dispatcher.build_url("admin", "services", "nps"))
    luci.sys.call("( /usr/bin/nps update && /etc/init.d/nps restart ) >/tmp/nps_update.log 2>&1 &")
end

default_button = s:option(Button, "default_button", translate("Default Config"), translate("Clicking this button will replace the current configuration with the default configuration file."))
default_button.modal = false
function default_button.write(self, section, value)
    luci.sys.call(string.format("[ -f %s ] && cp %s %s.bak.$(date +%%Y%%m%%d%%H%%M%%S)", conf_file_path, conf_file_path, conf_file_path))
    local default_conf_file = io.open("/etc/nps/conf/nps.conf.default", "r")
    if default_conf_file then
        local default_content = default_conf_file:read("*a")
        default_conf_file:close()
        local conf_file = io.open(conf_file_path, "w")
        if conf_file then
            conf_file:write(default_content)
            conf_file:close()
        end
    end
    luci.http.redirect(luci.dispatcher.build_url("admin", "services", "nps"))
end

github_button = s:option(Button, "github_button", "Github", "https://github.com/djylb/nps-openwrt")
github_button.modal = false
function github_button.write(self, section, value)
    luci.http.status(200)
    luci.http.redirect("https://github.com/djylb/nps-openwrt")
end

return m
