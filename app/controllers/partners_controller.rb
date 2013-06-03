#encoding: utf-8
##
# The controller for Partner class.

class PartnersController < ApplicationController
  before_filter :require_partner_login
  skip_before_filter :require_login, :require_partner_login, :only => [:loginform, :login]
  #skip_before_filter :require_partner_login, :only => [:loginform, :login]
  ##
  # Shows login form to the partner.

  def loginform
    @error = Hash.new
  end

  ##
  #
  #

  def login
    partner = Partner.find_by_username(params[:username])
    @error = Hash.new
    if  partner
      session[:partner] = partner
      redirect_to partners_path and return
    end
    @error[:error] = "Virheellinen käyttäjätunnus tai salasana"
    render "loginform"
  end


  def require_partner_login
    unless logged_in?

      redirect_to partner_login_path
    end
    @partner = session[:partner]
  end

##
# Checks if admin is logged in.
#@return boolean value is user logged in.

  def partner_logged_in?
    !!session[:partner]
  end

  def index

  end

  ##
  # Clears all from session and redirects to login form page.
  def partner_logout
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to partner_login_path
  end
end