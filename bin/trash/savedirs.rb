#!/usr/bin/env ruby

dirs = [] 
ARGF.each { |line| dirs.push(line) }

dirs.reverse.each { |line|
  puts "pushd #{line.chomp.gsub(/s/, ' ')}"
}
