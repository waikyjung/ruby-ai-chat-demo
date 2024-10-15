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
    @user_statement = gets.chomp
    @message_list.push({"role" => "user", "content" => @user_statement})
    until @user_statement.downcase == "bye" do
      @api_response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: @message_list
        }
      )

      @system_response = @api_response.fetch("choices")[0].fetch("message").fetch("content")
      puts
      puts "Chatbot:"
      puts "#{@system_response}"
      @message_list.push({"role" => "system", "content" => @system_response})
      
      puts
      puts "Reply:"
      @user_statement = gets.chomp
      @message_list.push({"role" => "user", "content" => @user_statement})
    end
  end
end

new_chat = Chat.new
new_chat.start
