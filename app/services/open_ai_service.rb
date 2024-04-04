class OpenAiService
  def self.generate_coffee_suggestion(input)
      uri = URI.parse("https://api.openai.com/v1/chat/completions")
      request = Net::HTTP::Post.new(uri)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{ENV['OPENAI_ACCESS_TOKEN']}"
      request.body = {
      model: "gpt-3.5-turbo", # または "gpt-4" など、使用するモデル名を指定
      messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: input }
      ]
      }.to_json

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
      end

      if response.is_a?(Net::HTTPSuccess)
      body = JSON.parse(response.body)
      body["choices"]&.first&.fetch("message", {}).fetch("content", "").strip
      else
      Rails.logger.error "OpenAI API Error: #{response.body}"
      nil
      end
  end
end
  