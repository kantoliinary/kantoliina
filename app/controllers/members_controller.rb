##
# Controller for member class

class MembersController < ApplicationController
  before_filter :require_login

  ##
  # Show new member page to user.
  # if old member in flash[:member], saves it to @member.

  def new
     @member = flash[:member] || Member.new
  end

  ##
  # Creates new member with params[:member] and try save it.
  # If save succeed, adds flash[:notice] message otherwise adds members informations to flash[:member].
  # Redirect to new member page.

  def create

    @member = Member.new(params[:member])

    if @member.save
      flash[:notice] = "Jasen lisatty!"
    else
      flash[:member] = @member
    end
    redirect_to new_member_path
  end

  def update
    @member = Member.find([:membernumber])
    if @member.as_null_object
      flash[:notice] = "Jasenta ei loydetty!"
    else
      @member.updated_at
    end
  end

  ##
  # Lists all members to @members and shows list page.

  def index
    @members = Member.all
  end

  private

  ##
  # Checks is user logged in and redirect to login form if not.

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

  ##
  # Checks is admin in session.
  #@return boolean value is user logged in.

  def logged_in?
    !!session[:admin]
  end
end