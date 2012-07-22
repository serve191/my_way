require 'dm-types'

module Auth
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= auth_with_session || auth_with_login || false
    end

    def auth_with_session
      User.first(:id => session[:user_id])
    end

    def auth_with_login
      if params[:user]
        if u = User.first(:login => params[:user][:login])
          u if u.password == params[:user][:password]
        end 
      end
    end
end
