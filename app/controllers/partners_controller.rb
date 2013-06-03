#encoding: utf-8
##
# The controller for Partner class.

class PartnersController < ApplicationController

  ##
  # Shows login form to the partner.

  def loginform
    @error = Hash.new
  end

  ##
  #
  #

  def login
    partner = Partner.find_by_username(params[:username]).try(:authenticate, params[:password])
    @error = Hash.new
    if  partner
      session[:partner] = partner
      redirect_to search_member_path and return
    end
    @error[:error] = "Virheellinen käyttäjätunnus tai salasana"
    render "loginform"
  end


  def require_login
    unless logged_in?

      redirect_to login_path
    end
    @partner = session[:partner]
  end

##
# Checks if admin is logged in.
#@return boolean value is user logged in.

  def logged_in?
    !!session[:partner]
  end



  ##
  # Clears all from session and redirects to login form page.
  def logout
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to login_path
  end
end