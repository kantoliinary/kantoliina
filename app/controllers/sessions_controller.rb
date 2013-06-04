#encoding: UTF-8
class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  ##
  # Shows login form to the admin.
  def new
    redirect_to members_path unless session[:admin_id].blank?
    @error = Hash.new
  end

  ##
  # Saves logged Admin to sessions[:admin] if username and password are correct, and redirects to members list page.
  # Adds error to @error[:error] if username or password is incorrect, and rerenders login form.
  def create
    admin = Admin.find_by_username(params[:username]).try(:authenticate, params[:password])
    @error = Hash.new
    if  admin
      session[:admin_id] = admin.id
      redirect_to members_path and return
    end
    @error[:error] = "Virheellinen käyttäjätunnus tai salasana"
    render "new"
  end

  ##
  # Clears all from sessions and redirects to login form page.
  def destroy
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to login_path
  end
end