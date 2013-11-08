#!/usr/bin/env ruby

STORE="#{ENV['HOME']}/.clipboard-history"
LIMIT=100

unless File.exist?(STORE)
File.open(STORE, 'w') { |f| f.write('') }
end

clips = File.read(STORE).split(/\n/).map { |c| eval(c) }

if ARGV[0] == 'menu'
if sel = eval(`cat #{STORE} | dmenu -p 'select a paste'`)
IO.popen('xclip -i -selection clipboard', 'w') { |f| f.write(sel) }
end
else
loop do
clip = `xclip -o -selection clipboard`
if clip != clips.last
clips.unshift clip
File.open(STORE, 'w') do |file|
file.write(clips.uniq[0...LIMIT].map { |c| "#{c.inspect}\n" }.join())
end
end
sleep 1
end
end
