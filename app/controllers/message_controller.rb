class MessageController < ApplicationController
    before_action :authorize_user, only: [:new]
  
    def new
      if params[:talent_id] == current_user.id
        redirect_to inbox_path, notice: "You can't message yourself."
      else
        @message = Message.new
        @message_receiver = params[:talent_id]
        @receiver_info = User.find(@message_receiver)
      end
    end
  
    def create
      @message = Message.new(message_params)
      @message.message_sender = current_user
  
      if @message.save
        redirect_to conversation_path(user: @message.message_receiver_id)
      else
        redirect_to new_message_path(talent_id: @message.message_receiver_id), notice: 'Failed to create message.'
      end
    end

    def inbox
        if current_user.role.role_name == "owner"
            @inbox = current_user.sent_messages.select(:message_receiver_id).distinct
        else
            @inbox = current_user.received_messages.select(:message_sender_id).distinct
        end
    end    

    def conversation
      @conversation_user = User.find(params[:user])
      @message = Message.where(
        "(message_sender_id = :current_user_id AND message_receiver_id = :conversation_user_id) OR 
        (message_sender_id = :conversation_user_id AND message_receiver_id = :current_user_id)",
        current_user_id: current_user.id, 
        conversation_user_id: @conversation_user.id
      )
      @new_message = Message.new
    end
  
    private
  
    def message_params
      params.require(:message).permit(:content, :message_receiver_id)
    end
  
    def authorize_user
        unless current_user.role.role_name == "owner"
            redirect_to dashboard_path, notice: 'Please wait for the Job Listing Owner to message you.'
        end
    end
end
  