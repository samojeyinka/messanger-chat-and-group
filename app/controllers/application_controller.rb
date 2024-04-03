class ApplicationController < ActionController::Base
    helper_method :current_user, :isloggedIn? 
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id];
    end

    def isloggedIn? 
        !!current_user
    end

    def require_user
        if !isloggedIn?
            flash[:alert] = "You are not logged in"
            redirect_to signin_path
    end
end

end