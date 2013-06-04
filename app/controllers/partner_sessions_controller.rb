#encoding: UTF-8
## The controller controlling the session functionalities in partner pages.
#
#
class PartnerSessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :destroy]

  ##
  # Shows login form to a partner.
  #
  def new
    @error = Hash.new
    @title = "Yhteistyökumppanin sisäänkirjautuminen"
    @form_path = partner_login_path
  end

  ##
  # Checks if a partner exist and the username is correct. If this is true, redirects to the main partner page
  # If not, shows an error message to the user.
  def create
    partner = Partner.find_by_username(params[:username]).try(:authenticate, params[:password])
    @error = Hash.new
    if  partner
      session[:partner_id] = partner.id
      redirect_to partners_path and return
    end
    @error[:error] = "Virheellinen käyttäjätunnus tai salasana!"
    render "new"
  end

  ##
  # Clears all from sessions and redirects to the login form page.
  def destroy
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to partner_login_path
  end
end
