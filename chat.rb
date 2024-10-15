require "openai"

class Chat
  attr_accessor :message_list

  def initialize
    @api_key = ENV.fetch("OPENAI_API_KEY")
    @client = OpenAI::Client.new(access_token: @api_key)
    @message_list = [{"role" => "system", "content" => "You are a helpful assistant."}]
  end

  def separate
    puts
    puts "-" * 50
    puts
  end

  def start
    puts "Chatbot: Hello! How can I help you today?"
    self.separate
    
    puts "Reply:"
    @user_statement = gets.chomp
    @message_list.push({"role" => "user", "content" => @user_statement})
    self.separate
    
    until @user_statement.downcase == "bye" do
      @api_response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: @message_list
        }
      )
      @system_response = @api_response.fetch("choices")[0].fetch("message").fetch("content")
      @message_list.push({"role" => "system", "content" => @system_response})
      puts "Chatbot:"
      puts "#{@system_response}"
      self.separate
      
      puts "Reply:"
      @user_statement = gets.chomp
      @message_list.push({"role" => "user", "content" => @user_statement})
      self.separate
    end
  end
  puts "Chatbot: Goodbye!"
  self.separate
end

new_chat = Chat.new
new_chat.start
