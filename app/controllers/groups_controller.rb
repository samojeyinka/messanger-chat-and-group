class GroupsController < ApplicationController
def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    @groups = Group.public_groups
    @users = User.all_except(@current_user)
    @pinned_users = User.all_except(@current_user).take(3)
    @group = Group.new
    @online_users = User.all_except(@current_user).take(7)
end

def create
    @group = Group.create(name: params["group"]["name"])
  end

  def show
    @current_user = current_user
    @single_group = Group.find(params[:id])
    @groups = Group.public_groups
    @users = User.all_except(@current_user)
    @group = Group.new
    @message = Message.new
    @messages = @single_group.messages
    @online_users = User.all_except(@current_user).take(7)
    @pinned_users = User.all_except(@current_user).take(3)
  
    render "index"
  end

end
