#!/usr/bin/ruby
 
require 'rubygems'
require 'net/http'
require 'cgi'
require 'xmlsimple'
 
# key from API documentation
$lastfm_key = "4eb9b8039585ebae81399eda40492643" 
$lastfm_host = "ws.audioscrobbler.com"
 
def fetch_cover(artist, album)
  artist = CGI.escape(artist)
  album = CGI.escape(album)
 
  path = "/2.0/?method=album.getinfo&api_key=#{$lastfm_key}&artist=#{artist}&album=#{album}"
  data = Net::HTTP.get($lastfm_host, path)
  xml = XmlSimple.xml_in(data)

  return nil unless xml['status'] == 'ok'

  album = xml['album'][0]
  return album['image'][3]['content']
end
 
# puts fetch_cover('Nickelback', 'Dark Horse')

