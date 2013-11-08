#!/usr/bin/env ruby

require 'colorize'

class MpvPlayer
def initialize( input )
@input = input.first
@path_to = {
:playlist => "/tmp/playlist",
:fifo => "/tmp/mpv.fifo",
:log => "/tmp/mpv.log"
}
@mpv = {
:process => "mpv",
:bin => "/usr/bin/mpv",
}
@mpv_options = [
"--input-file=#{@path_to[:fifo]}",
"--no-consolecontrols",
"--playlist=#{@path_to[:playlist]}",
"--really-quiet"
]
end

def msg( input )
print ":: ".blue, input, "\n"
end

def err( input = nil )
print ":: ".red, input, "\n" unless input.nil?
abort
end

def usage
msg("Possible arguments: FILE or ACTION")
# msg("Actions list")
# actions.each_key { |key| puts "\s\s\s\s#{key}" }
end

def is_running?( process )
system "ps -C #{process} -opid= &>/dev/null"
return $? == 0
end

def create_playlist( file_name )
file_path = File.realdirpath(file_name)
file_dir = File.dirname(file_path)

f = File.open(@path_to[:playlist], "w+") do |f|
match = false
glob_pattern = '*.{mkv,mp4,avi,mpg}'
glob_dir = File.join(file_dir.gsub(/[*?{}\[\]]/, '\\\\\\&'), glob_pattern)

Dir.glob(glob_dir, File::FNM_CASEFOLD) do |path|
if File.file?(path)
match = true if path == file_path
f.puts path if match
end
end
end
end

def fifo( input )
actions = {
"toggle" => "cycle pause",
"forward" => "osd-msg-bar seek +5",
"rewind" => "osd-msg-bar seek -5",
"next_chapter" => "add chapter 1",
"prev_chapter" => "add chapter -1",
"playlist_next" => {
"0" => "playlist_next",
"1" => "show_text \"\$\{filename\}\""
},
"playlist_prev" => {
"0" => "playlist_prev",
"1" => "show_text \"\$\{filename\}\""
},
"next_audio" => "cycle audio",
"next_subtitle" => "cycle sub",
"quit" => "quit",
"volume_up" => "add volume 1",
"volume_down" => "add volume -1",
"mute" => "cycle mute",
"osd" => "cycle osd-level",
"file" => "show_text \"\$\{filename\}\"",
"progress" => "show_progress",
"fullscreen" => "cycle fullscreen"
}

pipe = []
if actions.has_key?(input)
pipe = actions[input]
else
if File.file?(File.realdirpath(input))
create_playlist(@input)
pipe.push("loadlist \"#{@path_to[:playlist]}\" replace")
pipe.push("show_text \"\$\{filename\}\"")
end
end

err("Action or File not recognized.") if pipe.empty?

output = open(@path_to[:fifo], "w+")
output.puts *pipe
output.flush
end

def _clean
system("pkill redshift-schedu &>/dev/null") if is_running?("redshift-schedu")
File.delete(@path_to[:fifo]) if File.exist?(@path_to[:fifo])
system("mkfifo", @path_to[:fifo])
File.delete(@path_to[:playlist]) if File.exist?(@path_to[:playlist])
end

def _exit
system("redshift-scheduler &>/dev/null &") unless is_running?("redshift-schedu")
File.delete(@path_to[:fifo]) if File.exist?(@path_to[:fifo])
File.delete(@path_to[:playlist]) if File.exist?(@path_to[:playlist])
end

def start
if @input.nil?
usage
err()
end

if is_running?(@mpv[:process])
msg("#{@mpv[:process]} is already running.")
msg("Sending action/file - #{@input}")
fifo(@input)
else
err("#{@input} is not an actual file.") unless File.file?(@input)

_clean

msg("Queueing files.")
create_playlist(@input)

msg("Playing - #{@input}")
system(@mpv[:bin], *@mpv_options)
at_exit { _exit }
end
end
end

if __FILE__ == $0
x = MpvPlayer.new(ARGV)
x.start()
end
