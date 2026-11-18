-- Helpers of the NPC pages: reading a pasted npc command line, and short
-- summaries of launch and access links for the lists.
local M = {}

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


M.shell_words = shell_words
M.parse_import = parse_import
M.section_name = section_name

-- server returns host:port and the carrier of an npc:// link, or nil.
function M.server(link)
	link = link or ""
	local hostport = link:match("^npc://[^@]*@([^/?#]+)")
	if not hostport then
		return nil
	end
	local carrier = link:match("[?&]type=([%w_]+)") or "tcp"
	local paths = 1
	for _ in link:gmatch("[?&]alt=") do paths = paths + 1 end
	return hostport, carrier, paths
end

-- access returns the listener, target and connection of an access link.
function M.access(link)
	link = link or ""
	local scheme, rest = link:match("^([%w_]+)://(.*)$")
	if not scheme then
		return link, "", ""
	end
	local listen = rest:gsub("[?#].*$", ""):gsub("^.*@", "")
	local target = link:match("[?&]target=([^&#]+)") or ""
	local via = link:match("[?&]via=([^&#]+)") or ""
	return scheme .. "://" .. listen, target, via
end

-- import adds the connections and accesses of text to uci (a luci.model.uci
-- cursor), skipping links already present. It returns how many it added.
function M.import(uci, text)
	local conns, access = parse_import(text)
	local seen, added = {}, 0
	uci:foreach("npc", "connection", function(sec) seen[sec.link or ""] = true end)
	uci:foreach("npc", "access", function(sec) seen[sec.link or ""] = true end)
	for _, l in ipairs(conns) do
		l = l:gsub("%s+", "")
		local bare = l:gsub("#[^#]*$", "")
		if not seen[l] and not seen[bare] then
			uci:section("npc", "connection", section_name(uci, l, "conn"), { enabled = "1", link = l:match("^npc://") and bare or l })
			seen[l], seen[bare], added = true, true, added + 1
		end
	end
	for _, l in ipairs(access) do
		l = l:gsub("%s+", "")
		if not seen[l] then
			uci:section("npc", "access", section_name(uci, l, "access"), { enabled = "1", link = l })
			seen[l], added = true, added + 1
		end
	end
	return added
end

return M
