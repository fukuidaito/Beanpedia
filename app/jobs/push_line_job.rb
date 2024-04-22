class PushLineJob < ApplicationJob
require 'line/bot'
queue_as :default

def perform(user, board=nil)
  message_text = "ログインありがとう！"
  message_text = "#{board.title} が作成されました！" if board.present?

  message = {
    type: 'text',
    text: message_text
  }

  response = line_client.push_message(user.uid, message)
  Rails.logger.info "LINE message send response: #{response.body}" if response.present?

  if response.code != '200'  # HTTPステータスコードを文字列で比較
    Rails.logger.error "LINE API Error: Status #{response.code} - #{response.body}"
  end
end

private

def line_client
  @line_client ||= Line::Bot::Client.new do |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  end
end
end
