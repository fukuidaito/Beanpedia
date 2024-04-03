require 'open-uri'
require 'net/http'
require 'json'

class OpenAiService
  def self.generate_coffee_suggestion(input)
    uri = URI.parse("https://api.openai.com/v1/engines/text-davinci-003/completions")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{ENV['OPENAI_ACCESS_TOKEN']}"
    request.body = { prompt: input, max_tokens: 100 }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end

    # レスポンス処理を追加
    if response.is_a?(Net::HTTPSuccess)
      body = JSON.parse(response.body)
      body["choices"]&.first&.fetch("text", "").strip
    else
      # OpenAIからのエラーメッセージやステータスコードをロギング
      Rails.logger.error "OpenAI API Error: #{response.body}"
      nil # エラーがあった場合はnilを返す
    end
  end
end