require 'dm-types'

module Auth
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= auth_with_session || auth_with_email || false
    end

    def auth_with_session
      User.first(:id => session[:user_id])
    end

    def auth_with_email
      if params[:user]
        if u = User.first(:email => params[:user][:email])
          u if u.password == params[:user][:password]
        end 
      end
    end
end
