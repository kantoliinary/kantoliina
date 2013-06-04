#encoding: utf-8
class PasswordResetsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def new
  end

  def create
    admin = Admin.find_by_email(params[:email])
    if admin
      admin.generate_and_send_new_password
    end
    redirect_to login_path
  end
end