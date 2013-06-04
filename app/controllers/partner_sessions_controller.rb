#encoding: UTF-8
class PartnerSessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :destroy]

  def new
    @error = Hash.new
  end

  ##
  #
  #

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
  # Clears all from sessions and redirects to login form page.
  def destroy
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to partner_login_path
  end
end
