#!/usr/bin/env ruby

STORE="#{ENV['HOME']}/.clipboard-history"
LIMIT=100
unless File.exist?(STORE)
File.open(STORE, 'w') {
  |f| f.write('')
}
end

puts 'read clips'
clips = File.read(STORE).split(/\n/).map { |c| eval(c) }

        if ARGV[0] == 'menu'
            puts 'show menu'
            if sel = eval(`cat #{STORE} | ~/.config/dmenu/clip -p 'select a paste'`)
        IO.popen('xclip -i -selection clipboard', 'w') {
        |f| f.write(sel)
    }
end
    else
        loop do
            clip = `xclip -o -selection clipboard`
                   if clip != clips.first
                   puts 'add clip'
                   clips = ([clip] + clips).uniq[0...LIMIT]
                               File.open(STORE, 'w') do |file|
                                   file.write(clips.map { |c| "#{c.inspect}\n" } .join())
                                   end
                                   end
                                   sleep 1
                                   end
                                   end

