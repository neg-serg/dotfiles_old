#!/usr/bin/ruby
 
#
# Moved to: https://github.com/uriel1998/volumerb
#
# This work is licensed under the Creative Commons Attribution-ShareAlike 3.0
# Unported License. To view a copy of this license, visit
# http://creativecommons.org/licenses/by-sa/3.0/.
#
# Forked/derived from original by Jasper Van der Jeugt (jaspervdj);
# large chunks rewritten by Steven Saus (uriel1998)
# This is designed to set your pulseaudio volume settings, muting, and
# default sink from the command line. It will even switch currently
# running streams to the new sink when you switch it!
# Usage will be largely for folks who are using keybinds for volume, etc.
# Originally wrote this to work with ALSA cards - that's what I have.
# (see line 46) but the code at line 45 *should* work for anything
# that's set up as a device in PulseAudio. This is written to work
# with the version of PulseAudio I have on my system - 0.9.22.
# By perusing the online PulseAudio documentation, it looks like this
# *should* still work just fine for later versions. Please ping me one
# way or another so I can properly document/fix it...
 
# To do: -Set toggle (like the q toggle) so that actions only impact
# current default sink
# -Add in toggle so simple output available for notify-osd
 
# 20121114:uriel1998: Added introduction/description above
# 20121114:uriel1998: Standardized indentations
# 20121114:uriel1998: Rewrote if/else statements into case statements
# 20121114:uriel1998: Added usage instructions when no arguments given
# 20121114:uriel1998: Added quiet option
# 20121114:uriel1998: Added explicit setting of volume
# 20121114:uriel1998: Added explicit muting/unmuting instead of just
# toggling mute
# 20121114:uriel1998: Formatted output to be somewhat more human-
# readable, including padding & volume percentages
# 20121114:uriel1998: Added function to allow changing default sink
# 20121114:uriel1998: Added code to switch playing streams to new sink.
# 20121114:uriel1998: Rewrote array; arranged by sink id instead of name
# 20120210:uriel1998: Changed bit of code toggling mute
# 20120210:uriel1998: Added output, so it could be piped to a notify-osd
# or somesuch if desired. (superceded 20121114)
# 20120210:uriel1998: Original fork from https://gist.github.com/814634
 
 
# Function to test if argument is number, from
#http://stackoverflow.com/questions/5661466/test-if-string-is-a-number-in-ruby-on-rails
class String
def is_number?
true if Float(self) rescue false
end
end
 
# Pulseaudio volume control
class Pulse
attr_reader :volumes, :mutes
 
# Constructor
def initialize
dump = `pacmd dump`.lines
@volumes = {}
@mutes = {}
@names = {}
@id = {}
$longname = 0
 
dump.each do |line|
args = line.split
 
#We are using the id to actually enumerate this bloody array.
if !args[2].nil? and args[2].include? "device_id" then # this should work for any recognized device
#if args[1] == "module-alsa-card" then # this works if you only have ALSA cards.
s1 = args[2].sub("device_id=\"","")
s2 = s1.sub("\"","")
number = s2.to_i
@id[number] = number
crapstring = args[3].sub("name=\"","")
@names[number] = crapstring.sub("\"","")
if @names[number].length > $longname
$longname = @names[number].length
end
else
if @names.keys.length > 0 # we already have something in the array
@names.keys.each do |sink|
if !args[1].nil? and args[1].include? @names[sink] # and if it's a sink we recognize AND not nil...
result = case args[0]
when "set-default-sink" then $defaultsink = args[1].sub("alsa_output.","") # static variable
when "set-sink-volume" then @volumes[@id[sink]] = args[2].hex
when "set-sink-mute" then @mutes[@id[sink]] = args[2]
end
end
end
end
end
end
 
# Adjust the volume with the given increment for every sink
def volume_set_relative(increment)
@volumes.keys.each do |sink|
volume = @volumes[sink] + increment
volume = [[0, volume].max, 0x10000].min
@volumes[sink] = volume
`pacmd set-sink-volume #{sink} #{"0x%x" % volume}`
end
end
 
# Adjust the volume with the given increment for every sink
def volume_set_absolute(setvol)
if setvol < 100.1
@volumes.keys.each do |sink|
volume = setvol * 65536 / 100
@volumes[sink] = volume
`pacmd set-sink-volume #{sink} #{"0x%x" % volume}`
end
end
end
 
# Toggle the mute setting for every sink
def mute_toggle
@mutes.keys.each do |sink|
if @mutes[sink] == "yes"
`pacmd set-sink-mute #{sink} no`
else
`pacmd set-sink-mute #{sink} yes`
end
end
end
def mute(setting)
@mutes.keys.each do |sink|
`pacmd set-sink-mute #{sink} #{setting}`
end
end
 
# give me that sweet percentage value.
def percentage(vol)
return vol * 100 / 65536
end
 
def setdefault
@names.keys.each do |sink|
if $defaultsink.include? @names[sink]
puts "#{@id[sink]}. #{@names[sink]} *"
else
puts "#{@id[sink]}. #{@names[sink]}"
end
end
puts "Which sink shall be set as default (enter the number)"
scratch = STDIN.gets.chomp
newdefault = scratch.to_i
if @id.include? newdefault
`pacmd set-default-sink #{newdefault}`
 
# Now to move all current playing stuff to the new sink....
dump2 = `pacmd list-sink-inputs`.lines
@inputs = {}
counter = 0
dump2.each do |line|
args = line.split
if args[0] == "index:" # We need to find the item index for each playing stream
@inputs[counter] = args[1]
counter += 1
end
end
# And now to shift them all to the new sink.
count2 = 0
while count2 < counter
`pacmd move-sink-input #{@inputs[count2]} #{newdefault}`
count2 += 1
end
else
puts "That input index does not exist. You silly person."
end
end
 
 
# so we can have nice things.
def padstring(strlen)
dyncounter = 0
counter = $longname.to_i - strlen.to_i
padder = " "
while dyncounter < counter do
padder << " "
dyncounter += 1
end
return padder
end
 
# Report out settings for each sink.
def status
# needed to get new values
initialize
puts "##Current status##########################################"
puts "ID Sink Name#{padstring(11)} Mute Vol Default"
@id.keys.each do |sink|
# making volume into a percentage for humans
# Not sure why I have to pass to a subprocess to make it do, but...
volpercent = percentage(@volumes[sink])
if $defaultsink.include? @names[sink]
puts "#{@id[sink]}. #{@names[sink]}#{padstring(@names[sink].length)} #{@mutes[sink]} #{volpercent}% *"
else
puts "#{@id[sink]}. #{@names[sink]}#{padstring(@names[sink].length)} #{@mutes[sink]} #{volpercent}%"
end
end
puts "##########################################################"
end
end
 
# Control code
p = Pulse.new
unless ARGV.length > 0
puts "\nUsage: ruby volume.rb [0-100|up|down|toggle|mute|unmute|default] [q]\n[0-100] - set percentage of max volume for all sinks\nup|down - Changes volume on all sinks\ntoggle|mute|unmute - Sets mute on all sinks\ndefault - Select default sink from commandline\nq - quiet; no status output\n"
else
if ARGV.first.is_number?
absvolume = ARGV.first.to_i
p.volume_set_absolute(absvolume)
else
result = case ARGV.first
when "up" then p.volume_set_relative 0x1000
when "down" then p.volume_set_relative -0x1000
when "toggle" then p.mute_toggle
when "mute" then p.mute("yes")
when "unmute" then p.mute("no")
when "default" then p.setdefault
# status not needed; it's included
end
end
end
# Always give us the results.
if !ARGV.include? "q"
p.status
end
end
