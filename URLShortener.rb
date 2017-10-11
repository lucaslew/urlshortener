# URLShortener.rb
require 'sinatra'
require 'sqlite3'

db = SQLite3::Database.new( "data.db" )
setups = [
  'create table if not exists shorten_url(Id INTEGER PRIMARY KEY, shortened_code TEXT, url TEXT)'
  ]
for action in setups
  db.execute action
end

get '/' do
  erb :'index' 
end

get '/:shortcode' do
  shortcode = params['shortcode']
  target_url = ""
  db.execute "select url from shorten_url where shortened_code='" + shortcode + "'" do |row|
    target_url = row[0]
  end
  if target_url.empty?
    erb :'error' 
  else
    redirect target_url, 303
  end
end

post '/shorten' do
  shorten_code = rand(36**5).to_s(36)
  db.execute "insert into shorten_url(shortened_code, url) values(\"#{shorten_code}\", \"#{params['url']}\")"
  puts request.host
  'http://' + request.host + '/' + shorten_code
end

get /\/.*\/{1,}/ do
  erb :'error'
end
