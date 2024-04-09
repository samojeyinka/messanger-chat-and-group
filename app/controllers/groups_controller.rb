class GroupsController < ApplicationController
def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    # @groups = Group.public_groups.reverse
    if params[:query].present?
        @groups = Group.where("name LIKE ?", "%#{params[:query]}%")
    else
      @groups = Group.public_groups
      .left_joins(:messages)
      .group(:id)
      .order('MAX(messages.created_at) DESC')
    end
    @users = User.all_except(@current_user)
    @online_users = User.all_except(@current_user).take(7)
    @pinned_users = User.all_except(@current_user).take(3)
    @group = Group.new
    # @online_users = User.all_except(@current_user).take(7)

end


def create
    @group = Group.create(name: params["group"]["name"],description: params["group"]["description"],coverPhoto: params["group"]["coverPhoto"])
      flash[:notice] = "Group created successfully"
      redirect_to @group
  end

  def show
    @current_user = current_user
    @single_group = Group.find(params[:id])
    # @groups = Group.public_groups
    @groups = Group.public_groups
    .left_joins(:messages)
    .group(:id)
    .order('MAX(messages.created_at) DESC')
    @users = User.all_except(@current_user)
    @group = Group.new
    @message = Message.new
    @messages = @single_group.messages
    @online_users = User.all_except(@current_user).take(7)
    @pinned_users = User.all_except(@current_user).take(3)
   
    render "index"
  end

end
