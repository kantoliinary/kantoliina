#encoding: utf-8
##
# The controller for Partner class.

class PartnersController < ApplicationController
  before_filter :require_partner_login
  skip_before_filter :require_login, :only => [:index, :partner_logout, :loginform, :login]
  skip_before_filter :require_partner_login, :only => [:loginform, :login]

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


  private

  def require_partner_login
    unless partner_logged_in?

      redirect_to partner_login_path
    end
  end

##
# Checks if admin is logged in.
#@return boolean value is user logged in.

  def partner_logged_in?
    !!session[:partner_id]
  end

end