-- Return the union of two Lua tables.
-- ...and if the same element appears in both tables with different values...?
-- The current, cheap implementation just has t2 overriding t1 whenever they have the same index.
function union(t1, t2)
	t = {}
	for i,v in pairs(t1) do
		t[i] = v
	end
	for i,v in pairs(t2) do
		t[i] = v
	end
	return t
end

