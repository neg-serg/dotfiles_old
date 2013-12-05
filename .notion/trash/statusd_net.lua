-------------------------------------------------------------------------------------------
--
-- PURPOSE:
--   Shows received/transmited data in b/k/m/g on any interface.
--
-- USAGE:
--   Just set any of the following labels on cfg_statusbar.lua: %net_IFACE
--   Example: [ eth0: %net_eth0 ]
--
--   Then configure, write (on cfg_statusbar.lua) something like this, without comments:
--      net = {
--         eth0 = {
--            interval  = 5 * 1000, --> Milliseconds
--            interface = "eth0",   --> Itnerface to monitoring
--         },
--      }
--
-- Responsible for bugs and so on: Andrey A. Ugolnik <andrey@ugolnik.info>
--
-------------------------------------------------------------------------------------------


local netconf		= table.join(statusd.get_config("net"), {})
local get_net_data	= nil
local timers	= {}


-- convert bytes to Kb / Mb / Gb
local function bytes2human(bytes)
	local b		= tonumber(bytes)
	local out	= bytes .. "b"
	if b > 1024*1024*1024 then
		out	= string.format("%.3fg", b / (1024*1024*1024))
	else
		if b > 1024*1024 then
			out	= string.format("%.2fm", b / (1024*1024))
		else
			if b > 1024 then
				out	= string.format("%.1fk", b / 1024)
			end
		end
	end
	return out
end


get_net_data	= function (name)
	local iface		= netconf[name].interface
	local status	= ""
	local sysfile	= io.open("/sys/class/net/" .. iface .. "/operstate", 'r')
	local color		= "gray"
	local rxo		= "n"
	local txo		= "a"	-- like as n/a
	local essid		= ""
	local strength	= ""
	if sysfile == nil then
		status		= "n/a"
	else
		local operstate	= sysfile:read()
		sysfile:close()
		if operstate ~= "down" then
			color	= "green"

			local tx		= io.open("/sys/class/net/" .. iface .. "/statistics/tx_bytes", 'r')
			txo			= bytes2human(tx:read())
			tx:close()
			local rx		= io.open("/sys/class/net/" .. iface .. "/statistics/rx_bytes", 'r')
			rxo			= bytes2human(rx:read())
			rx:close()
			status	= rxo .. " " .. txo

			-- determine ESSID by calling /sbin/iwconfig
			local show_essid	= netconf[name].show_essid or false
			if show_essid == true then
				local iwconfig		= io.popen('/usr/sbin/iwconfig wlan0')
				local line			= iwconfig:read()
				local essid_start	= line:find("ESSID:")
				essid					= line:sub(essid_start + 7, line:len() - 3) 

				local f	= io.open("/sys/class/net/wlan0/wireless/link")
				strength	= f:read().."%"
				f:close()
				status	= essid.." "..strength..status
			end
		else
			status	= "off"
		end
	end
	statusd.inform("net_"..name, status)
	statusd.inform("net_"..name.."_hint", color)

	statusd.inform("net_in_"..name, rxo)
	statusd.inform("net_in_"..name.."_hint", color)
	statusd.inform("net_out_"..name, txo)
	statusd.inform("net_out_"..name.."_hint", color)
	statusd.inform("net_essid_"..name, essid)
	statusd.inform("net_essid_"..name.."_hint", color)
	statusd.inform("net_strength_"..name, strength)
	statusd.inform("net_strength_"..name.."_hint", color)

	local interval	= netconf[name].interval or 60 * 1000 -- each minute by default
	timers[name]:set(interval, function() get_net_data(name) end)
end


-- Init
for name in pairs(netconf) do
	timers[name]	= statusd.create_timer()
	get_net_data(name)
end

