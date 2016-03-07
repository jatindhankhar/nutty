require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'active_record'
require 'bundler/setup'
require 'yaml'

require './models/song.rb'

enable :sessions # For keeping track of votes for a song
# configure(:development) { set :session_secret, "something" }

########## Database configuration #################

dbconfig = YAML.load(ERB.new(File.read('config/database.yml')).result)
RACK_ENV ||= ENV['RACK_ENV'] || 'development'
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

if ENV['OPENSHIFT_RUBY_LOG_DIR']
  LOG_FILE = "#{ENV['OPENSHIFT_RUBY_LOG_DIR']}/#{RACK_ENV}.log"
  ActiveRecord::Base.logger = Logger.new(File.open(LOG_FILE, 'a+'))
else
  Dir.mkdir('log') if !File.exist?('log') || !File.directory?('log')
  ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", 'a+'))
end

#################################################
get '/' do
  session['song_id'] = nil
  erb :index
end

post '/' do
  if params[:category]
    res = Song.where(genre: params[:category]).order('RANDOM()').first
    session['song_id'] = res.id
    res.lyric.to_s

  else
    'No such genre'
  end
end

post '/vote' do
  if params[:type] && session['song_id']
    target = session['song_id'].to_i
    puts target
    if params[:type] == 'upvote'
      Song.find(target).increment!(:upvote)
      params[:type] + "d"
    end
		if params[:type] == 'downvote'
			Song.find(target).increment!(:downvote)
			params[:type] + "d"
		end
 end
end
