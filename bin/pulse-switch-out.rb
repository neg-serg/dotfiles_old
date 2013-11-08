#!/usr/bin/ruby
# Filename:	pulse-switch-out
# Author:	David Ljung Madison <DaveSource.com>
# See License:	http://MarginalHacks.com/License/
# Description:	Switch pulse audio output (sink) using pacmd

PACMD = %w(pacmd)

##################################################
# Usage
##################################################
def fatal(*msg)
  msg.each { |m| $stderr.puts "[#{$0.sub(/.*\//,'')}] ERROR: #{m}" }
  exit(-1);
end

def usage(*msg)
  msg.each { |m| $stderr.puts "ERROR: #{m}" }
  $stderr.puts <<-USAGE

Usage:  #{$0.sub(/.*\//,'')} [sink]
  Switch sound playback device for ALSA/pulseaudio

  [sink]   Specify sink number to use (see 'pacmd list-sinks')

  USAGE
  exit -1;
end

def parseArgs
  opt = Hash.new
  loop {
    if (arg=ARGV.shift)==nil then break
    elsif arg == '-h' then usage
    elsif arg == '-?' then usage
    #elsif arg == '-arg' then opt[:arg] = true
    elsif arg =~ /^(\d)$/ then opt[:sink] = arg.to_i
    else
      usage("Unknown arg [#{arg}]")
    end
  }

  opt
end

# Unfortunately you can't return or break from the yield without leaving
# the pipe open, maybe use some sort of ensure and figure out how to close?
def pipe(cmd)
    # This is leaving files open
  #IO.popen(cmd.join(' ')).each { |l|
  a = `#{cmd.join(' ')}`
  ret = $?
  a.each { |l|
    yield l
  }
  $?
end

def getSinks(ins=false)
  cmd = PACMD.dup
  cmd.push(ins ? 'list-sink-inputs' : 'list-sinks')
  curr = nil
  sinks = Array.new
  pipe(cmd) { |l|
    next unless l=~/\s*(\*)?\s*index:\s+(\d+)/
    i = $2.to_i
    sinks.push(i)
    curr = i if $1
  }
  return sinks,curr
end

##################################################
# Main code
##################################################
def main
  opt = parseArgs

  sinks,curr = getSinks

  usage("No sinks found?") if sinks.empty?
  usage("Only one sink found") if sinks.size==1

  if opt[:sink]
    usage("Unknown sink [#{opt[:sink]}] (out of #{sinks.join(' ')})") unless sinks.index(opt[:sink])
  else
    # Find next sink after curr
    opt[:sink] = sinks[0]
    sinks.each { |s|
      next unless s>curr
      opt[:sink] = s
      break
    }
  end

  # Set default sink
## For some reason this doesn't change the behavior of new apps.
  puts "Set sink: #{opt[:sink]}"
  system("#{PACMD} set-default-sink #{opt[:sink]} > /dev/null")
  usage("Couldn't set default sink [#{opt[:sink]}]") unless $?==0

  # And move all sink-inputs to the new sink
  ins,ignore = getSinks(true)
  ins.each { |i|
    puts "Move playback #{i} to sink #{opt[:sink]}"
    system("#{PACMD} move-sink-input #{i} #{opt[:sink]} > /dev/null")
    usage("Couldn't move playback #{i} to sink [#{opt[:sink]}]") unless $?==0
  }
end
main
