require './api.rb'

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
  api_post(,ENV['WEBHOOK_URL_IZUMI'],attachments:[post])
  return 'あれっ？'
end