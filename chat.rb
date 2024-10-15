include "openai"

pp "hi"
client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI_KEY"))
