require 'line/bot'

class PushLineJob < ApplicationJob
  queue_as :default

  def perform(user_id, board_id = nil)
    user = User.find(user_id)
    board = Board.find(board_id) if board_id.present?

    message_text = 'ログインありがとう！'
    message_text = "#{board.title} が作成されました！" if board

    message = {
      type: 'text',
      text: message_text
    }

    client = line_client
    response = client.push_message(user.uid, message)

    if response.code == '200'
      Rails.logger.info "メッセージ送信成功: #{response.body}"
    else
      Rails.logger.error "メッセージ送信失敗: #{response.code} #{response.body}"
    end
  end

  private

  def line_client
    Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end
  end
end
