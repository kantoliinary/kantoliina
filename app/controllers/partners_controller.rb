#encoding: utf-8
##
# The controller for Partner class.

class PartnersController < ApplicationController
  before_filter :require_partner_login
  skip_before_filter :require_login, :only => [:index, :partner_logout, :loginform, :login]
  skip_before_filter :require_partner_login, :only => [:update]

  ##
  # Shows login form to a partner.
  def index
    @message = Hash.new
    if params[:number]
      member = Member.find_by_membernumber(params[:number])
      if member && member.membership
        @message[:notice] = "Henkilön jäsenyys on voimassa."
      else
        @message[:notice] = "Henkilön jäsenyys ei ole voimassa."
      end
    end
  end

  def update
    admin = Admin.find(session[:admin_id]).try(:authenticate, params[:admin_password])
    if admin
      partner = Partner.find(params[:id])
      unless params[:partner][:password].empty?
        if partner.update_attributes(params[:partner])
          flash[:partnernotice] = "Tiedot päivitetty"
        else
          flash[:partner] = partner
        end
      else
        partner.username = params[:partner][:username]
        if partner.validate_username && partner.save(:validate => false)
          flash[:partnernotice] = "Käyttäjätunnus päivitetty"
        else
          flash[:partner] = partner
        end
      end
    else
      flash[:partner] = partner
      flash[:partnererror] = "Tunnuksen muokkaus ei onnistunut"
    end
    redirect_to accountcontrols_path and return
  end

  private

  ##
  # Checks if a partner is logged in and redirects the user to the login page if not.
  def require_partner_login
    unless partner_logged_in?

      redirect_to partner_login_path
    end
  end

##
# Checks if admin is logged in.
#@return boolean value is the user logged in.

  def partner_logged_in?
    !!session[:partner_id]
  end

end