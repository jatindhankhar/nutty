require './app.rb'
puts ENV["RACK_ENV"]
puts Song.count
