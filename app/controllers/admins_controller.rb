##
# Controller for admin class

class AdminsController < ApplicationController

  ##
  # Shows login form to user.

  def loginform
    @error = Hash.new
  end

  ##
  # Saves logged admin to session[:admin] if login and password correct, and redirect to members list page.
  # Add error to @error[:error] if incorrect username or password, and renders login form.

  def login
    admin = Admin.find_by_login(params[:login]).try(:authenticate, params[:password])
    @error = Hash.new
    if  admin
      session[:admin] = admin
      redirect_to members_path and return
    end
    @error[:error] = "Virheellinen kayttajatunnus tai salasana"
    render "loginform"
  end

  ##
  # Clears all from session and redirect to login form page.
  def logout
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to login_path
  end
end