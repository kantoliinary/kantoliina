#encoding: utf-8
##
# A controller controlling the admin password recovery
#
class PasswordResetsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def new
  end

  ##
  # Identifies an admin by an e-mail address given by the user, generates a new password and sends it to the e-mail given.
  #
  def create
    admin = Admin.find_by_email(params[:email])
    if admin
      admin.generate_and_send_new_password
    end
    redirect_to login_path
  end
end