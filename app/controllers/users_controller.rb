class UsersController < ApplicationController
    before_action :find_user, only: [:profile,:show,:edit,:update, :destroy]
    before_action :require_user, only: [:profile]
    before_action :require_exact_user, only: [:edit, :update, :destroy]
#users lists
def index
    @users = User.all_except(current_user)
end

def profile
end

#each user show route
def show
    @current_user = current_user
    @groups = Group.public_groups
    @users = User.all_except(@current_user)
    @group = Group.new
    @message = Message.new
    @group_name = get_name(@user, @current_user)
    @single_group = Group.where(name: @group_name).first || Group.create_private_group([@user, @current_user], @group_name)
    @messages = @single_group.messages
    @online_users = User.all_except(@current_user).take(7)
    @pinned_users = User.all_except(@current_user).take(3)

    render "groups/index"
end

#signup route or new user route
def new
    @user = User.new
end

#new user action
def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "User created successfully"
        redirect_to root_path
    else
      render 'new'
    end
end

#edit user route
def edit
end

#edit user action
def update
     if @user.update(user_params)
        flash[:notice] = "User updated successfully"
        redirect_to root_path
    else
      render 'edit'
    end
end

#deletes user action
def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account deleted successfully!"
    redirect_to root_path
  end







private

def user_params
    params.require(:user).permit(:username,:password,:password_confirmation,:avatar)
end

def find_user
    @user = User.find(params[:id]) 
end

def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end

  def require_exact_user
    if current_user != @user
       flash[:alert] = "You do not have permission to perform this action"
          redirect_to root_path
       end
 end

end
