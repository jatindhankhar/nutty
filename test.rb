require './app.rb'

def add_entry lyric,genre
	Song.create( :lyric => lyric, :genre => genre)
end


files = Dir.glob ENV["OPENSHIFT_DATA_DIR"] + "*.txt" # Find all text files

files.each do |f|
	open(f).each_line.to_a.sample(25).each do |lyric|
		add_entry(lyric,File.basename(f,".txt")) # Add each lyric with genre to Database
	end
end

