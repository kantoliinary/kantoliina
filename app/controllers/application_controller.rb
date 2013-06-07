##
# The controller for ensuring the admin login functionality

class ApplicationController < ActionController::Base
  before_filter :require_login
  protect_from_forgery

  private

##
# Checks that admin is logged in and redirects the admin to the login form if not.

  def require_login
    unless logged_in?
      redirect_to login_path and return
    end
    @admin = Admin.find(session[:admin_id])
  end

##
# Checks if admin is logged in.
#@return boolean value is user logged in.

  def logged_in?
    !!session[:admin_id]
  end
end


