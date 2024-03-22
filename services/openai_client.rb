require 'openai'

class OpenaiClient
  def initialize
    @client = OpenAI::Client.new(api_key: ENV['OPENAI_API_KEY'])
  end

  def suggest_coffee(survey)
    prompt = "Based on the following preferences: bitterness: #{survey.bitterness}, acidity: #{survey.acidity}, body: #{survey.body}, origin: #{survey.origin}, suggest a coffee."
    response = @client.completions(engine: 'davinci', prompt: prompt, max_tokens: 50)
    response.choices.first.text.strip
  end
end