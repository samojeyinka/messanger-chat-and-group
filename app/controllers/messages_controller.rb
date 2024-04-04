class MessagesController < ApplicationController
    def create
        @current_user = current_user
        @message = @current_user.messages.create(body: msg_params[:body], group_id: params[:group_id])
      end
    
      private
    
      def msg_params
        params.require(:message).permit(:body)
      end
end
