require 'open-uri'
require 'rubygems'
require 'json'

stations_link = 'https://open.fm/api/static/stations/stations_new.json'


open('openfm.m3u', 'w') do |file|
  file.write(
      JSON.parse(
          open(stations_link).read
      )['channels'].map do |channel|
        [
            channel['name'],
            channel['id']
        ]
      end.map do |name, id|
        [
            "#EXTINF:#{id}, #{name}",
            "https://stream.open.fm/#{id}"
        ]
      end.flatten.unshift('#EXTM3U').join("\n")
  )
end