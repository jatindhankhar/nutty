require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'active_record'
require 'bundler/setup'
require 'yaml'

require "./models/song.rb"

dbconfig = YAML.load(ERB.new(File.read("config/database.yml")).result)

# YOU MUST SET THE ENV RACK_ENV to 'production' FOR YOUR CATRIDGE
RACK_ENV ||= ENV["RACK_ENV"] || "development"
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

if ENV["OPENSHIFT_RUBY_LOG_DIR"]
	LOG_FILE = "#{ENV["OPENSHIFT_RUBY_LOG_DIR"]}/#{RACK_ENV}.log"
	ActiveRecord::Base.logger = Logger.new(File.open(LOG_FILE, 'a+'))
else
	Dir.mkdir('log') if !File.exist?('log') || !File.directory?('log')
	ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", "a+"))
end

get '/' do
	erb :index

end


post '/' do
	#content_type :json
	puts params
	if params[:category]
		Song.where(:genre => params[:category]).order("RANDOM()").first.lyric.to_s
	else
   "No such genre"
	end
end

post '/vote' do
 puts params
end
