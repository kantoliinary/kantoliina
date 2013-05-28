#encoding: utf-8
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

  ##
  # Deletes the member with params[:member] and try save it.
  # If save succeed, deletes flash[:notice] message otherwise not delete member flash[:member].
  # Redirect to members page.

  def destroy
    @member = Member.find(params[:id])
    if @member == false
      flash[:notice] = "Jäsenta ei löydetty!"
    else
      @member.membership = false
      if @member.save
        flash[:notice] = "Jäsen poistettu"
        redirect_to members_path
      else
        flash[:notice] = "Jäsenen poisto ei onnistunut"
        redirect_to members_path
      end
    end
  end

  ##
  # Lists all members to @members and shows list page.

  def index
    @members = Member.all
    @all_sort_fields = Member.all_sort_fields
    @selected_sort_fields = params[:sort_fields] || {}
    @keyword = params[:keyword] || ""

  end

  ##
  #

  def edit
    @member = Member.find(params[:id])

  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes!(params[:member])
      flash[:notice] = "Tiedot muutettu"
    else
      flash[:member] = @member
    end
    redirect_to edit_member_path
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


