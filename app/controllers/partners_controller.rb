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
    partner = Partner.find_by_login(params[:login]).try(:authenticate, params[:password])
    @error = Hash.new
    if  partner
      session[:partner] = parner
      redirect_to partners_path and return
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