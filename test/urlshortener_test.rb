ENV['RACK_ENV'] = 'test'

require '../URLShortener'
require 'test/unit'
require 'rack/test'
require 'sqlite3'

class URLShortenerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index_page_loaded_successfully
    get '/'
    assert last_response.ok?
    assert last_response.body.include?("Enter URL Here");
  end
  
  def test_generate_short_url
    post '/shorten', :url => 'http://www.google.com'
    shorten_code = last_response.body
    change_domain_short_code = shorten_code.gsub('http://example.org/', '')
    assert change_domain_short_code.match(/^[0-9a-z]*$/)
  end

  def test_redirect
    db = SQLite3::Database.open( "data.db" )
    shortened_code = ''
    target_url = ''
    db.execute "select shortened_code, url from shorten_url limit 1" do |row|
      shortened_code = row[0]
      target_url = row[1]
    end

    get "/#{shortened_code}" 
    follow_redirect!

    assert_equal "http://www.google.com/", last_request.url
    assert last_response.ok?

  end

  def test_error_page
    get '/1231231'
    assert last_response.body.include?('Something went wrong. Cannot redirect to intended page.')
  end
end
