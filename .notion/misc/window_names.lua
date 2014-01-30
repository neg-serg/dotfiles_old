-- Testing if you can publish a window list from Ion that's readable from elsewhere somehow (via text stream, temporary file, socket, etc).
-- Basically lifted from ioncore/ioncore_menudb.lua

local ioncore=_G.ioncore

local function sort(entries)
	table.sort(entries, function(a, b) return a.name < b.name end)
	return entries
end



local function addto(list)
	-- This is nifty: it creates a menuentry that will switch to the target window frame when activated.
	return function(tgt, attr)
		local e=menuentry(tgt:name(), function() tgt:goto() end)
		e.attr=attr;
	--	table.insert(tgt:name())
		table.insert(list, e)
	--	print(e)	--OK, e, a menuentry, is a table.
	--	print("window_names.addto(): adding " .. tgt:name())
		return true
	end
end



function get_ion_windows()
	local entries={}
	-- clientwin_i is an iterator, and will apply the supplied function to all client windows (until the function returns false).
--	ioncore.clientwin_i(function(tgt, attr) table.insert(entries, tgt:name()); return true end)
	ioncore.clientwin_i(addto(entries))
	return sort(entries)
end


function log_ion_window_names()
	for index,window in ipairs(get_ion_windows()) do
	--	print(window_name)
	--	print(window_name.name)
	--	for i,v in ipairs(window_name) do
	--		print(i)
		--	print(i .. " -> " .. v)
	--	end
		os.execute("logger 'Ion3: log_ion_window_names(): " .. window.name .. "'")
	--	os.execute("logger 'Ion3: log_ion_window_names(): " .. window_index .. "'")
	--	os.execute("logger 'Ion3: log_ion_window_names(): " .. window_name .. "'")
	end
end

