require "openai"
require "json"

class Chat
  attr_accessor :message_list

  def initialize
    @api_key = ENV.fetch("OPENAI_API_KEY")
    @client = OpenAI::Client.new(access_token: @api_key)
    @message_list = [{"role" => "system", "content" => "You are a helpful assistant."}]
  end

  def start
    puts "Say something to chatbot:"
    @user_statement = ""
    until @user_statement.downcase == "bye" do
      @user_statement = gets.chomp
      @message_list.push({"role" => "user", "content" => @user_statement})
      @api_response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: @message_list
        }
      
      )
      pp @api_response
    end
  end
end

new_chat = Chat.new
new_chat.start
