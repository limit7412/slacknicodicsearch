require 'sinatra'
# require 'sinatra/reloader'
require "faraday"

require './src/scraping.rb'

# エラーハンドリング用
def error_post(error)
  message = 'エラーみたい…確認してみよっか'
  post = {
    fallback: message,
    pretext: "<@#{ENV['SLACK_ID']}> #{message}",
    title: error.message,
    text: error.backtrace.join('\n'),
    color: "#EB4646",
    footer: "github_notifications_slack",
  }
  api_post('あれっ？',ENV['WEBHOOK_URL_IZUMI'],attachments:[post])
end

def api_post(app_res,url,params)
  post_res = Faraday.post url, params.to_json
  return {
    res: post_res,
    params: params
  }.to_json
  # return app_res
end

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
      api_post('',ENV['WEBHOOK_URL_MIO'],scraping.get_dic)
    end
  rescue => error
    error_post error
  end
end