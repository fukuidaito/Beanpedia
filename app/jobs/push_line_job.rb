class PushLineJob < ApplicationJob
require 'line/bot'
queue_as :default

  def perform(user_uid)
    message = {
        type: 'text',
        text: 'ログインありがとう！'
    }
    response = line_client.push_message(user_uid, message)
    logger.info "PushLineSuccess: #{response}" if response
  end

    private

    def line_client
    Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    end
end
