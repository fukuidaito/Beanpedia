require 'line/bot'

class PushLineJob < ApplicationJob
    queue_as :default

  def perform(user)
      message = {
      type: 'text',
      text: 'ログインありがとう！'
      }
      response = line_client.push_message(user.uid, message)
      logger.info "LINE API Response: #{response.body}"
  end

  private

  def line_client
      Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
  end
end
