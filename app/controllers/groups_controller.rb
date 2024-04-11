class GroupsController < ApplicationController
  # before_action :require_user, except: [:index]


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
     @group.user = current_user
     if @group.save
    flash[:notice] = "Group created successfully"
      redirect_to @group
     else 
      render 'new'
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

  private
  def require_exact_user
    if current_user != @user
       flash[:alert] = "You do not have permission to perform this action"
          redirect_to root_path
       end
 end

end


end
