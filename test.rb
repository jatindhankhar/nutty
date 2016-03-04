require_relative  'models/song.rb'
puts ENV["RACK_ENV"]
puts Song.count
