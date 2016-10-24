class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :bootstrap_class_for



  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    !!current_user && current_user.admin?
  end

  def bootstrap_class_for(flash_type)
   case flash_type.to_sym
     when :success
       "alert-success"
     when :info
       "alert-info"
     when :warning
       "alert-warning"
     when :error
       "alert-danger"
     else
       flash_type.to_s
   end
 end

end
