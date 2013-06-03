#encoding: utf-8
##
# The controller for Partner class.

class PartnersController < ApplicationController
  before_filter :require_partner_login
  skip_before_filter :require_login, :only => [:check_membership, :find_member_status, :partner_logout, :loginform, :login]
  skip_before_filter :require_partner_login, :only => [:loginform, :login]
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
      session[:partner_id] = partner.id
      redirect_to partners_path and return
    end
    @error[:error] = "Virheellinen käyttäjätunnus tai salasana!"
    render "loginform"
  end



  def check_membership

  end

  def find_member_status

    member = Member.find_by_membernumber(params[:number])
    if member && member.membership
      flash[:notice] = "Henkilön jäsenyys on voimassa."
    else
      flash[:notice] = "Henkilön jäsenyys ei ole voimassa."
    end
    redirect_to partners_path
  end


  ##
  # Clears all from session and redirects to login form page.
  def partner_logout
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to partner_login_path
  end

  private

  def require_partner_login
    unless partner_logged_in?

      redirect_to partner_login_path
    end
    @partner = session[:partner]
  end

##
# Checks if admin is logged in.
#@return boolean value is user logged in.

  def partner_logged_in?
    !!session[:partner_id]
  end

end