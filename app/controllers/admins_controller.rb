#encoding: utf-8
##
# The controller for Admin class.

class AdminsController < ApplicationController

  ##
  # Shows login form to the admin.

  def loginform
    @error = Hash.new
  end

  ##
  # Saves logged Admin to session[:admin] if username and password are correct, and redirects to members list page.
  # Adds error to @error[:error] if username or password is incorrect, and rerenders login form.

  def login
    admin = Admin.find_by_username(params[:username]).try(:authenticate, params[:password])
    @error = Hash.new
    if  admin
      session[:admin] = admin
      redirect_to members_path and return
    end
    @error[:error] = "Virheellinen käyttäjätunnus tai salasana"
    render "loginform"
  end

  ##
  # Clears all from session and redirects to login form page.
  def logout
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to login_path
  end
end