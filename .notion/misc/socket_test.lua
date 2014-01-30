-- Simple Lua sockets demo: an echo server.
-- http://www.tecgraf.puc-rio.br/~diego/professional/luasocket/introduction.html

-- I think this will need to be run as a separate thread, to avoid blocking/causing Ion to hang.
-- LuaSocket currently doesn't implement local domain sockets, so we'll have to use IP sockets for now.


function echo_server()

-- load namespace
local socket = require("socket")

-- We need a known port number for clients to connect to:
local port = 42000

-- create a TCP socket and bind it to the local host, at any port
--local server = assert(socket.bind("*", 0))
local server = assert(socket.bind("127.0.0.1", port))

-- find out which port the OS chose for us
--local ip, port = server:getsockname()

-- print a message informing what's up
print("Please telnet to localhost on port " .. port)
print("After connecting, you have 10s to enter a line to be echoed")

-- loop forever waiting for clients
while 1 do
	-- wait for a connection from any client
	print("	waiting for client connection...")
	local client = server:accept()

	-- make sure we don't block waiting for this client's line
	print("	client connected; activating 10 s timeout...")
	client:settimeout(10)

	-- receive the line
	local line, err = client:receive()
	print("	received data.")

  -- if there was no error, send it back to the client
	if not err then client:send(line .. "\n") end

  -- done with client, close the object
	client:close()
	print("	client connection closed.")
end

-- Is the fact that this loops indefinitely (potentially blocking all the while) gonna be a probalo?

end



-- Use coroutines to spawn the server as a separate thread:

-- OK, making the server function called indirectly avoids the hang at startup...
echo_server_thread = coroutine.create(function() echo_server() end)
--echo_server_thread = coroutine.create(echo_server())
--echo_server_thread = coroutine.create(function() print "hi" end)

-- Will it hang if we don't resume the server thread?
print(coroutine.status(echo_server_thread))
--coroutine.resume(echo_server_thread)
print(coroutine.status(echo_server_thread))
-- no, but it still hangs when it's run (resumed). :(  What's the point in having coroutines if they don't run as parallel threads?  Oh, they have to yield() - co-operative multitasking.

