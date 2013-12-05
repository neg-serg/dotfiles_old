-- Small interface to MusicPD
--
-- Author: Steve Jothen <sjothen at gmail dot com>
--
-- Requires netcat
local netcat = "/usr/bin/netcat"
local settings = {
  hostname = "localhost",
  password = nil,
  port = 6600,
  volume_delta = 10
}

MusicPD = {}

function MusicPD.file_exists()
  if io.open(netcat, "r") then -- check to see if file exists
    return true
  else
    return false
  end
end

-- creates the appropriate string to call with io.popen
--
function MusicPD.create_command(command)
  local arguments = nil
  if settings.password then
    arguments = string.format(
                "echo -n \"password %s\n%s\nclose\n\" | %s %s %d",
                settings.password, command, netcat, settings.hostname, settings.port)

  else
    arguments = string.format(
                "echo -n \"%s\nclose\n\" | %s %s %d",
                command, netcat, settings.hostname, settings.port)
  end
  return arguments
end

-- calls the command and returns table of key, value pairs
-- 
function MusicPD.call_command(command)
  local arg_cmd = MusicPD.create_command(command)
  local values = {}
  if MusicPD.file_exists() then
    local handle = io.popen(arg_cmd, "r")
    local line = handle:read("*l")
    while line do
      local _, _, key, value = string.find(line, "(.+):%s(.+)")
      if key then
        values[string.lower(key)] = value
      end
      line = handle:read("*l")
    end
    handle:close()
  end
  return values
end

function MusicPD.next()
  MusicPD.call_command("next")
end

function MusicPD.previous()
  MusicPD.call_command("previous")
end

function MusicPD.pause()
  MusicPD.call_command("pause")
end

function MusicPD.stop()
  MusicPD.call_command("stop")
end

function MusicPD.volume_up()
  local stats = MusicPD.call_command("status")
  local cur_volume = tonumber(stats.volume)
  local new_volume
  if cur_volume == 100 then
    return nil
  elseif cur_volume + settings.volume_delta > 100 then
    new_volume = string.format("setvol %d", 100) 
  else
    new_volume = string.format("setvol %d", settings.volume_delta + cur_volume)
  end
  MusicPD.call_command(new_volume)
end

function MusicPD.volume_down()
  local stats = MusicPD.call_command("status")
  local cur_volume = tonumber(stats.volume)
  local new_volume
  if cur_volume == 0 then
    return nil
  elseif cur_volume - settings.volume_delta < 0 then
    new_volume = string.format("setvol %d", 0)
  else
    new_volume = string.format("setvol %d", cur_volume - settings.volume_delta)
  end
  MusicPD.call_command(new_volume)
end

function MusicPD.toggle_random()
  local stats = MusicPD.call_command("status")
  local random = tonumber(stats.random)
  if random == 0 then
    MusicPD.call_command("random 1")
  elseif random == 1 then
    MusicPD.call_command("random 0")
  end
end

function MusicPD.toggle_repeat()
  local stats = MusicPD.call_command("status")
  local rpt = tonumber(stats["repeat"])
  if rpt == 0 then
    MusicPD.call_command("repeat 1")
  else
    MusicPD.call_command("repeat 0")
  end
end

function MusicPD.toggle_play()
  local stats = MusicPD.call_command("status")
  if stats.state == "play" then
    MusicPD.call_command("pause") 
  elseif stats.state == "pause" then
    MusicPD.call_command("pause")
  elseif stats.state == "stop" then
    MusicPD.call_command("play")
  end
end

