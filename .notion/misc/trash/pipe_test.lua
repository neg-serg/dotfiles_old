-- An Ion3 statusd meter for disk activity
-- Just a rough first stab, CME 2009-02-12

-- iostat -x -m 1 | grep --line-buffered sda | cut --bytes=99-

local f = io.popen("pwd") -- runs command
local l = f:read("*a") -- read output of command
print(l)
f:close()

-- It would be more efficient if we could leave iostat running, rather than invoking the command every refresh period.  Something like this:
local f = io.popen("iostat -x -m 1 | grep --line-buffered sda | cut --bytes=99-")
for line in f:lines("*n") do
	print(line)
end
f:close()

