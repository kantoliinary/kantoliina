#encoding: utf-8
##
# The controller for class Member.

class MembersController < ApplicationController
  before_filter :require_login

  ##
  # Shows new member page to the admin.
  # If old member in flash[:member], saves it to @member.

  def new
    @member = flash[:member] || Member.new
  end

  ##
  # Creates a new member with params[:member] and tries to save it.
  # If save succeeds, adds flash[:notice] message, otherwise adds members information to flash[:member].
  # Redirects to new member page.

  def create
    @member = Member.new(params[:member])
    if @member.save
      flash[:notice] = "Jäsen lisätty!"
    else
      flash[:member] = @member
    end
    redirect_to new_member_path
  end

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def invoice
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
  end


  ##
  # Deletes the member with params[:member] and tries to save it.
  # The interface informs the admin whether the save succeeded or not.
  # Redirects to the list page.

  def destroy
    @member = Member.find(params[:id])
    if @member == false
      flash[:notice] = "Jäsentä ei löydetty!"
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
  # Lists all members to @members and shows the list page.

  def index
    @membergroups = Membergroup.all
    @all_search_fields = Member.all_search_fields
    @selected_search_fields = params[:search_fields] || {}
    @keyword = params[:keyword] || ""
    @membership = params[:membership] || {"1" =>"1"}
    #puts "qaaaaaaaaaaaaaa"
    #puts @membership
    @paymentstatus = params[:paymentstatus] || {"0" => "0", "1" => "1"}
    s_membergroups = params[:membergroups]
    @selected_membergroups = (s_membergroups ? s_membergroups.keys : nil) || @membergroups.collect{|g| "#{g.id}" }
    @members = search_with_filter(@keyword, @selected_search_fields, @membership.keys, @paymentstatus.keys, @selected_membergroups)
  end

  ##
  #Edits the current Member with right parameters.

  def edit
    @member = flash[:member] || Member.find(params[:id])
  end

  ##
  #Replaces the selected attributes of a single member.
  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      flash[:notice] = "Tiedot muutettu!"
    else
      flash[:member] = @member
    end
    redirect_to edit_member_path
  end

  ##
  #Selects a group of members by chosen ID and sends an invoice to their e-mails.
  def send_invoices
    @members = Member.find_all_by_id(params[:member])
    @members.each do |member|
      Billing.bill_email(member).deliver
    end
    redirect_to members_path
  end

  private

##
# Checks that admin is logged in and redirects the admin to the login form if not.

  def require_login
    unless logged_in?

      redirect_to login_path
    end
    @admin = session[:admin]
  end

##
# Checks if admin is logged in.
#@return boolean value is user logged in.

  def logged_in?
    !!session[:admin]
  end

##
# Filters members by selected radio buttons. Values are membership and payment status with OR operation.
# If member has the field represented by the selected button, the subroutine searches for matching character combinations.


  def search_with_filter keyword, search_fields, membership, paymentstatus, membergroups
    keywords = keyword.split(" ")
    member = Member.includes(:membergroup)
    keywords.each do |word|
      query = ""
      query_keywords = {}
      counter = 65;
      search_fields.keys.each do |field|
        if Member.has_field?(field)
          query += (query.empty? ? "" : " OR ") + "#{field} LIKE :#{counter.chr}"
          query_keywords[counter.chr.to_sym] = "#{word}%"
          counter += 1
        end
      end
      member = member.where(query, query_keywords)
    end
    if membership.length == 1
      #puts membership.at(0).class
      member = member.where(:membership => membership.at(0) == "1")
    end
    if paymentstatus.length == 1
      member = member.where("expirationdate "+(paymentstatus.at(0) == "0" ? "<" : ">") +" ?", Time.now-1.day)
    end
    query = ""
    query_keywords = {}
    counter = 65;
    membergroups.each do |id|
      query += (query.empty? ? "" : " OR ") + "membergroup_id = :#{counter.chr}"
      query_keywords[counter.chr.to_sym] = id
      counter += 1
    end
    member.where(query, query_keywords)
  end

end
