class MessagesController < ApplicationController
  def create
    @group = Group.find(params[:group_id]);
      @message = @group.messages.build(message_params)
      @message.user = current_user
      if @message.save
        redirect_to @group, notice: 'Message sent successfully.'
      else
        @messages = @group.messages
        render 'groups/show'
      end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end


