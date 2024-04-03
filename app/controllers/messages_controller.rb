class MessagesController < ApplicationController
    before_action :require_user
def index
    @message = Message.new
    @messages = Message.all
end

def create
    message = current_user.messages.build(message_params)
    message.user = current_user
    if message.save
        redirect_to messages_path
    end
end

private 

 def message_params
    params.require(:message).permit(:body)
 
 end

end