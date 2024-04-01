class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(username: params[:session][:username])
  
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:notice] = "Signed in successfully"
        redirect_to user_by_username_path(username: user.username)
      else
        flash.now[:alert] = "Invalid signin credentials"
        render 'new'
      end
    end
  
    def destroy
      session[:user_id] = nil
      flash[:notice] = "Signed out successfully"
      redirect_to root_path
    end
  end
  