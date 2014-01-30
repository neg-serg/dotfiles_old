-- Obtain command name from process ID of its process
function get_command_from_pid(pid)
	f=io.popen("ps -p " .. pid .. " -o comm=")
	local command = f:read("*l")
	io.close(f)
	return command
end


