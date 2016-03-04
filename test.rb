require './app.rb'

def add_entry lyric,genre
	Song.create( :lyric => lyric, :genre => genre)
end


files = Dir.glob ENV["OPENSHIFT_DATA_DIR"] + "*.txt" # Find all text files

files.each do |f|
	puts "For genre #{File.basename(f,".txt")
	open(f).each_line.t_a.sample(25).each do |lyric|
		puts lyric
	end
end

