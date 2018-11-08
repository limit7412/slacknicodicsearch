require 'sinatra'
# require 'sinatra/reloader'
require './src/scraping.rb'
require './src/error_handling.rb'

get '/' do
  "Hello world"
end

post '/' do
  begin
    if params[:token] ==! ENV['SLACK_TOKEN']
      raise "TokenError"
    else
      scraping = Scraping.new(params[:text])
      scraping.get_top
      scraping.get_dic
      scraping.post_dic ENV['WEBHOOK_URL_MIO']
    end
  rescue => error
    error_post error
  end
end