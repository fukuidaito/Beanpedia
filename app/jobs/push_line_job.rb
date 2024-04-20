require 'line/bot'
class PushLineJob < ApplicationJob
    queue_as :default

  def perform(user)
      message = {
      type: 'text',
      text: 'ログインありがとう！'
      }
      response = line_client.push_message(user.uid, message)
      if response.code == '200'
      logger.info "PushLine Success: #{response.body}"
      else
      logger.error "PushLine Error: #{response.code} #{response.body}"
      end
  end

  private

  def line_client
      Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
  end
end