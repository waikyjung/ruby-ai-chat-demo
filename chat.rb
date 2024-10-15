require "openai"
require "json"

class Chat
  attr_accessor :message_list

  def initialize
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI_KEY"))
    @message_list = [{"role" => "system", "content" => "You are a helpful assistant."}]
  end

  def start
    until statement.downcase == "bye" do
      @user_statement = gets.chomp
      @message_list.push({"role" => "user", "content" => @user_statement})
      @api_response = client.chat(
        paramenters: {
          model: "gpt-3.5-turbo",
          messages: @message_list
        }
      
      )
      pp api_response
    end
  end
end

chat.start
